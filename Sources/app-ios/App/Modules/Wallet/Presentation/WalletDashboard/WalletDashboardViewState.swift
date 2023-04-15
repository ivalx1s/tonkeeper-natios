import Combine

@MainActor
final class WalletDashboardViewState: PerduxViewState {
	private var pipelines: Set<AnyCancellable> = []
	
	@Published private(set) var baseTokens: [BaseToken] = []
	@Published private(set) var fungibleTokens: [FungibleToken] = []
	@Published private(set) var nonFungibleTokens: [NonFungibleToken] = []
	@Published private(set) var nonLiquidAssets: [NonLiquidAsset] = []
	
	@Published private(set) var extendedLayout: TokenLayout = .aggregated
	
	
	init(walletState: WalletState) {
		initPipelines(walletState: walletState)
	}
	
	private func initPipelines(walletState: WalletState)  {
		walletState.walletAssets
			.receive(on: DispatchQueue.main)
			.sink { [weak self] assets in
				let assetsByType = Dictionary(grouping: assets, by: { $0.assetType })
				self?.baseTokens = assetsByType[.baseToken] as? [BaseToken] ?? []
				self?.fungibleTokens = assetsByType[.fungibleToken] as? [FungibleToken] ?? []
				self?.nonFungibleTokens = assetsByType[.nonFungibleToken] as? [NonFungibleToken] ?? []
				self?.nonLiquidAssets = assetsByType[.nonLiquidAsset] as? [NonLiquidAsset] ?? []
			}
			.store(in: &pipelines)
		
		Publishers.Zip4($baseTokens, $fungibleTokens, $nonFungibleTokens, $nonLiquidAssets)
			.map { base, ft, nft,  nlt in
				print("count: \(base.count), \(ft.count), \(nft.count), \(nlt.count)")
				if (base.count + ft.count + (nft.count * 2) + nlt.count) >= 10 {
					if base.count + ft.count + nlt.count >= 10 {
						return .discrete
					} else {
						return .hybrid
					}
				}
				return .aggregated
			}
			.receive(on: DispatchQueue.main)
			.assign(to: &$extendedLayout)
		
		$extendedLayout
			.removeDuplicates()
			.sink { layout in
				print("layout: \(layout)")
			}
			.store(in: &pipelines)
	}
}

extension WalletDashboardViewState {
	enum TokenLayout {
		case aggregated
		case hybrid
		case discrete
	}
}

