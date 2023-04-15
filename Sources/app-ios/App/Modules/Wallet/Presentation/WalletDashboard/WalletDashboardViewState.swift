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
					if ft.count + nlt.count >= 10 {
						if nlt.count > 0 {
							return .discrete
						} else {
							return .hybrid
						}
					} else {
						return .hybrid
					}
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
	enum TokenLayout: Equatable {
		case _aggregated(Array<AggregatedAssetType>)
		case _hybrid(Array<AggregatedAssetType>)
		case _discrete(Array<AggregatedAssetType>)
		
		static var aggregated: Self {
			._aggregated(
				[
					.fungibleAggregation(
						[
							.fungibleToken,
							//.nonLiquidAsset
						]
					),
					.nonFungibleAggregation(
						[
							.nonFungibleToken
						]
					)
				]
			)
		}
		
		static var hybrid: Self {
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

