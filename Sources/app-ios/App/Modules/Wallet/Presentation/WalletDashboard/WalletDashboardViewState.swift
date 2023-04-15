import Combine
//
//case baseToken
//case fungibleToken
//case nonFungibleToken
//case nonLiquidAsset

@MainActor
final class WalletDashboardViewState: PerduxViewState {
	private var pipelines: Set<AnyCancellable> = []
	
	@Published var baseTokens: [BaseToken] = []
	@Published var fungibleTokens: [FungibleToken] = []
	@Published var nonFungibleTokens: [NonFungibleToken] = []
	@Published var nonLiquidAssets: [NonLiquidAsset] = []
	
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
	}
}

