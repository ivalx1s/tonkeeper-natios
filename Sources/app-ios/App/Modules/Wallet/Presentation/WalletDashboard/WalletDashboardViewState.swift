import Combine
import TonkUI

@MainActor
final class WalletDashboardViewState: PerduxViewState {
	private var pipelines: Set<AnyCancellable> = []
	private let backgroundQueue = DispatchQueue(label: "WalletDashboardViewState-Background", qos: .userInteractive)
	
	@Published private(set) var fungibleTokens: [Numbered<FungibleToken>] = []
	@Published private(set) var nonFungibleTokens: [Numbered<NonFungibleToken>] = []
	@Published private(set) var nonLiquidAssets: [Numbered<NonLiquidAsset>] = []
	
	@Published private(set) var tokenLayout: WalletDashboardView.TokenLayout = .aggregated
	
	
	private let _fungibleTokensSubject = PassthroughSubject<[Numbered<FungibleToken>], Never>()
	private var fungibleTokensPublisher: AnyPublisher<[Numbered<FungibleToken>], Never> {
		_fungibleTokensSubject.eraseToAnyPublisher()
	}
	
	private let _nonFungibleTokensSubject = PassthroughSubject<[Numbered<NonFungibleToken>], Never>()
	private var nonFungibleTokensPublisher: AnyPublisher<[Numbered<NonFungibleToken>], Never> {
		_nonFungibleTokensSubject.eraseToAnyPublisher()
	}
	
	private let _nonLiquidAssetsSubject = PassthroughSubject<[Numbered<NonLiquidAsset>], Never>()
	private var nonLiquidAssetsPublisher: AnyPublisher<[Numbered<NonLiquidAsset>], Never> {
		_nonLiquidAssetsSubject.eraseToAnyPublisher()
	}
	
	init(walletState: WalletState) {
		initPipelines(walletState: walletState)
	}
	
	private func initPipelines(walletState: WalletState) {
		walletState.walletAssets
			.receive(on: backgroundQueue)
			.sink { [weak self] assets in
				guard let self else { return  }
				let assetsByType = Dictionary(grouping: assets, by: { $0.assetType })
				
				// ensuring collection is unique
				let fungibleTokens = (assetsByType[.fungibleToken] as? [FungibleToken] ?? [])
					.sorted(by: { $0.balance > $1.balance })
					.unique(by: \.id)
					.numbered(startingAt: 0)
				self._fungibleTokensSubject.send(fungibleTokens)
				
				
				// ensuring collection is unique
				let nonFungibleTokens = (assetsByType[.nonFungibleToken] as? [NonFungibleToken] ?? [])
					.sorted(by: { $0.balance > $1.balance })
					.unique(by: \.id)
					.numbered(startingAt: 0)
				self._nonFungibleTokensSubject.send(nonFungibleTokens)
				
				// ensuring collection is unique
				let nonLiquidAssets = (assetsByType[.nonLiquidAsset] as? [NonLiquidAsset] ?? [])
					.sorted(by: { $0.balance > $1.balance })
					.unique(by: \.id)
					.numbered(startingAt: 0)
				self._nonLiquidAssetsSubject.send(nonLiquidAssets)
			}
			.store(in: &pipelines)
		
		fungibleTokensPublisher
			.receive(on: DispatchQueue.main)
			.sink { [weak self] ft in
				guard let self else { return }
				//withAnimation {
					self.fungibleTokens = ft
				print("fungible count: \(ft.count)")
				//}
			}
			.store(in: &pipelines)
		
		nonFungibleTokensPublisher
			.receive(on: DispatchQueue.main)
			.sink { [weak self] nft in
				guard let self else { return }
				//withAnimation {
					self.nonFungibleTokens = nft
				//}
			}
			.store(in: &pipelines)
		
		nonLiquidAssetsPublisher
			.receive(on: DispatchQueue.main)
			.sink { [weak self] nlt in
				guard let self else { return }
				//withAnimation {
					self.nonLiquidAssets = nlt
				//}
			}
			.store(in: &pipelines)
		
		Publishers.Zip3($fungibleTokens, $nonFungibleTokens, $nonLiquidAssets)
			.map { (ft, nft,  nlt) -> WalletDashboardView.TokenLayout in
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
						return .hybridAllTokenPlusNft
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
						return .hybridAllTokenPlusNft
					}
				
					return .discrete
				}
				return .aggregated
			}
			.receive(on: DispatchQueue.main)
			.sink { [weak self] tokenLayout in
				guard let self else { return }
				//withAnimation {
					self.tokenLayout = tokenLayout
				//}
			}
			.store(in: &pipelines)
		
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
		case _aggregated(Array<AssetPage>)
		case _hybrid(Array<AssetPage>)
		case _discrete(Array<AssetPage>)
		
		var asPages: Array<Numbered<AssetPage>> {
			switch self {
				case let ._aggregated(aggregatedAssetTypes):
					return aggregatedAssetTypes.numbered(startingAt: 0)
				case let ._hybrid(aggregatedAssetTypes):
					return aggregatedAssetTypes.numbered(startingAt: 0)
				case let ._discrete(aggregatedAssetTypes):
					return aggregatedAssetTypes.numbered(startingAt: 0)
			}
		}
		
		static var aggregated: Self {
			._aggregated(
				[
					.page(
						[
							.fungibleToken,
							.nonLiquidAsset,
							.nonFungibleToken
						]
					),
				]
			)
		}
		
		/// Hybrid aggregation of a token and non-liquid asset types
		static var hybridTokenNla: Self {
			._hybrid(
				[
					.page(
						[
							.fungibleToken,
						]),
					.page(
						[
							.nonLiquidAsset
						]),
				]
			)
		}
		
		/// Hybrid aggregation of a token and nft asset types
		static var hybridAllTokenPlusNft: Self {
			._hybrid(
				[
					.page(
						.fungibleAndNonLiquid
					),
					.page(
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
					.page(
						[
							.nonFungibleToken
						]
					),
					.page(
						[
							.nonLiquidAsset
						]
					),
				]
			)
		}
		
		
		/// Discrete layout with each asset type has its own page
		static var discrete: Self {
			._discrete(
				[
					.page([.fungibleToken]),
					.page([.nonFungibleToken]),
					.page([.nonLiquidAsset]),
				]
			)
		}
	}
	
	// seems like we only need one case for aggregation
	enum AssetPage: Equatable, Hashable, Comparable, Identifiable {
		case page(Array<WalletAssetType>)
		
		var id: String {
			switch self {
				case let .page(assetTypes):
					return assetTypes.sorted(by: { $0.id < $1.id }).description
			}
		}
		
		static func < (lhs: AssetPage, rhs: AssetPage) -> Bool {
			switch (lhs, rhs) {
				case let (.page(lhsArray), .page(rhsArray)):
					return lhsArray.lexicographicallyPrecedes(rhsArray)
			}
		}
		
		var wrappedValue: [WalletAssetType] {
			switch self {
				case let .page(assetTypes):
					return assetTypes
			}
		}
		
	}
}

extension Array where Element == WalletAssetType {
	var isFungibleOrNonLiquid: Bool {
		let targetArray: Array<Element> = [.nonLiquidAsset, .fungibleToken]
		return self.contentEqualIgnoringOrder(targetArray)
	}
	
	static var fungibleAndNonLiquid: Self {
		[.fungibleToken, .nonLiquidAsset,]
	}
}

