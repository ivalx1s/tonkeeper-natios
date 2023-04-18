protocol IWalletSaga: PerduxSaga {
	
}


final class WalletSaga: IWalletSaga {
	
	private let walletSvc: IWalletService
	
	init(
		walletService: IWalletService
	) {
		self.walletSvc = walletService
	}
	
	func apply(_ effect: PerduxEffect) async {
		switch effect as? WalletSideEffect {
			case .loadStubWalletAssets:
				await loadWalletAssets()
			case .loadStubDataInBuffer:
				await loadStubDataInBuffer()
			case .addRandomFungibleToken:
				await addRandomFungibleToken()
			case .addRandomNonFungibleToken:
				await addRandomNonFungibleToken()
			case .deleteRandomFungibleToken:
				await deleteRandomFungibleToken()
			case .deleteRandomNonFungibleToken:
				await deleteRandomNonFungibleToken()
			case .addRandomNonLiquidAsset:
				await addRandomNonLiquidAsset()
			case .deleteRandomNonLiquidAsset:
				await deleteRandomNonLiquidAsset()
			case .none:
				break
		}
	}
	
	
	private func addRandomNonLiquidAsset() async {
		await addRandom(asset: .nonLiquidAsset)
		await reloadWalletAssets()
	}
	
	private func deleteRandomNonLiquidAsset() async {
		await walletSvc.deleteRandomAsset(of: .nonLiquidAsset)
		await reloadWalletAssets()
	}
	
	
	private func addRandomNonFungibleToken() async {
		await addRandom(asset: .nonFungibleToken)
		await reloadWalletAssets()
	}
	
	private func deleteRandomNonFungibleToken() async {
		await walletSvc.deleteRandomAsset(of: .nonFungibleToken)
		await reloadWalletAssets()
	}
	
	
	private func deleteRandomFungibleToken() async {
		await walletSvc.deleteRandomAsset(of: .fungibleToken)
		await reloadWalletAssets()
	}
	
	private func addRandomFungibleToken() async {
		await addRandom(asset: .fungibleToken)
		await reloadWalletAssets()
	}
	
	
	
	private func addRandom(asset type: WalletAssetType) async {
		await walletSvc.addRandomAsset(ofType: type)
	}
	
	private func loadStubDataInBuffer() async {
		await walletSvc.loadStubDataInBuffer()
	}
	
	private func reloadWalletAssets() async {
		let assets = await walletSvc.assets()
		await action {
			WalletAction.reloadAssetsInState(assets)
		}
	}
	
	private func loadWalletAssets() async {
		await walletSvc.loadStubData()
		await reloadWalletAssets()
	}
	
}
