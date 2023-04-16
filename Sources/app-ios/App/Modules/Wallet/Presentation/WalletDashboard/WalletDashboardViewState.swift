import Combine

@MainActor
final class WalletDashboardViewState: PerduxViewState {
	private var pipelines: Set<AnyCancellable> = []
	
	@Published private(set) var fungibleTokens: [FungibleToken] = []
	@Published private(set) var nonFungibleTokens: [NonFungibleToken] = []
	@Published private(set) var nonLiquidAssets: [NonLiquidAsset] = []
	
	@Published private(set) var tokenLayout: WalletDashboardView.TokenLayout = .aggregated
	
	init(walletState: WalletState) {
		initPipelines(walletState: walletState)
	}
	
	private func initPipelines(walletState: WalletState) {
		walletState.walletAssets
			.receive(on: DispatchQueue.main)
			.sink { [weak self] assets in
				let assetsByType = Dictionary(grouping: assets, by: { $0.assetType })
				self?.fungibleTokens = assetsByType[.fungibleToken] as? [FungibleToken] ?? []
				self?.nonFungibleTokens = assetsByType[.nonFungibleToken] as? [NonFungibleToken] ?? []
				self?.nonLiquidAssets = assetsByType[.nonLiquidAsset] as? [NonLiquidAsset] ?? []
			}
			.store(in: &pipelines)
		
		Publishers.Zip3($fungibleTokens, $nonFungibleTokens, $nonLiquidAssets)
			.map { ft, nft,  nlt in
				if (ft.count + (nft.count * 2) + nlt.count) >= 10 {
					// edge case when wallet contains only nfts
					if nft.count > 0, ft.count == 0, nlt.count == 0 {
						return .aggregated
					}
					
					// edge case when wallet contains only non liquid assets
					if nft.count == 0, ft.count == 0, nlt.count > 0 {
						return .aggregated
					}
					
					// edge case when wallet contains only token assets
					if nft.count == 0, ft.count > 0, nlt.count == 0 {
						return .aggregated
					}
					
					// edge case when wallet contains only nfts and non-liquid assets less than 10 by wight
					if ft.count == 0, (((nft.count * 2) + nlt.count) <= 10) {
						return .aggregated
					}
					
					// edge case when wallet contains only nfts and non-liquid assets more than 10 by wight
					if ft.count == 0, (((nft.count * 2) + nlt.count) > 10) {
						return .hybridNftNlt
					}
					
					// edge case when wallet contains only nfts and tokens 10 or less by wight
					if nlt.count == 0, ((ft.count + (nft.count*2)) <= 10) {
						return .aggregated
					}
					
					// edge case when wallet contains only nfts and tokens 10 or more by wight
					if nlt.count == 0, ((ft.count + (nft.count*2)) > 10) {
						return .hybridTokenNft
					}
					
					// edge case when wallet contains only tokens and non-liquid assets 10 or less by wight
					if nft.count == 0, ((ft.count + nlt.count) <= 10) {
						return .aggregated
					}
					
					// edge case when wallet contains only tokens and non-liquid assets 10 or more by wight
					if nft.count == 0, ((ft.count + nlt.count) > 10) {
						return .hybridTokenNla
					}
					
					// edge case when wallet contains tokens and non-liquid assets 10 or less by wight
					// and also contains nfts
					if nft.count > 0, ((ft.count + nlt.count) < 10) {
						return .hybridTokenNft
					}
				
					return .discrete
				}
				return .aggregated
			}
			.receive(on: DispatchQueue.main)
			.assign(to: &$tokenLayout)
		
		$tokenLayout
			.removeDuplicates()
			.sink { layout in
				print("layout: \(layout)")
			}
			.store(in: &pipelines)
	}
}

extension WalletDashboardView {
	enum TokenLayout: Equatable, Hashable {
		case _aggregated(Array<AggregatedAssetType>)
		case _hybrid(Array<AggregatedAssetType>)
		case _discrete(Array<AggregatedAssetType>)
		
		var asPages: Array<AggregatedAssetType> {
			switch self {
				case let ._aggregated(aggregatedAssetTypes):
					return aggregatedAssetTypes
				case let ._hybrid(aggregatedAssetTypes):
					return aggregatedAssetTypes
				case let ._discrete(aggregatedAssetTypes):
					return aggregatedAssetTypes
			}
		}
		
		static var aggregated: Self {
			._aggregated(
				[
					.fungibleAggregation(
						[
							.fungibleToken,
							.nonLiquidAsset,
							.nonFungibleToken
						]
					),
//					.nonFungibleAggregation(
//						[
//							.nonFungibleToken
//						]
//					)
				]
			)
		}
		
		/// Hybrid aggregation of a token and non-liquid asset types
		static var hybridTokenNla: Self {
			._hybrid(
				[
					.fungibleAggregation(
						[
							.fungibleToken,
						]),
					.fungibleAggregation(
						[
							.nonLiquidAsset
						]),
				]
			)
		}
		
		/// Hybrid aggregation of a token and nft asset types
		static var hybridTokenNft: Self {
			._hybrid(
				[
					.fungibleAggregation(
						[
							.fungibleToken,
							//.nonLiquidAsset
						]),
					.nonFungibleAggregation(
						[
							.nonFungibleToken
						]
					)
				]
			)
		}
		
		/// Hybrid aggregation of an nft and non-liquid asset types
		static var hybridNftNlt: Self {
			._hybrid(
				[
					.fungibleAggregation(
						[
							//.fungibleToken,
							.nonLiquidAsset
						]),
					.nonFungibleAggregation(
						[
							.nonFungibleToken
						]
					)
				]
			)
		}
		
		
		/// Discrete layout with each asset type has its own page
		static var discrete: Self {
			._discrete(
				[
					.fungibleAggregation([.fungibleToken]),
					.nonFungibleAggregation([.nonFungibleToken]),
					.fungibleAggregation([.nonLiquidAsset]),
				]
			)
		}
	}
	
	#warning("refactor AggregatedAssetType")
	// seems like we only need one case for aggregation
	enum AggregatedAssetType: Equatable, Hashable, Comparable, Identifiable {
		case fungibleAggregation(Array<WalletAssetType>)
		case nonFungibleAggregation(Array<WalletAssetType>)
		
		var id: String {
			switch self {
				case let .nonFungibleAggregation(assetTypes):
					return assetTypes.description
				case let .fungibleAggregation(assetTypes):
					return assetTypes.description
			}
		}
		
		static func < (lhs: AggregatedAssetType, rhs: AggregatedAssetType) -> Bool {
			switch (lhs, rhs) {
				case let (.fungibleAggregation(lhsArray), .fungibleAggregation(rhsArray)),
					let (.nonFungibleAggregation(lhsArray), .nonFungibleAggregation(rhsArray)):
					return lhsArray.lexicographicallyPrecedes(rhsArray)
				case (.fungibleAggregation, .nonFungibleAggregation):
					return true
				default:
					return false
			}
		}
		
		var wrappedValue: [WalletAssetType] {
			switch self {
				case let .nonFungibleAggregation(assetTypes):
					return assetTypes
				case let .fungibleAggregation(assetTypes):
					return assetTypes
			}
		}
		
	}
}

