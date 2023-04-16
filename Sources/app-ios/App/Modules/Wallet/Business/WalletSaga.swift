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
			case .loadWalletAssets:
				await loadWalletAssets()
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
		let ft = await getRandom(asset: .nonLiquidAsset) as? NonLiquidAsset
		if let ft {
			await action {
				WalletAction.addRandomAsset(ft)
			}
		}
	}
	
	private func deleteRandomNonLiquidAsset() async {
		await walletSvc.deleteRandomAsset(of: .nonLiquidAsset)
		await loadWalletAssets()
	}
	
	
	private func addRandomNonFungibleToken() async {
		let ft = await getRandom(asset: .nonFungibleToken) as? NonFungibleToken
		if let ft {
			await action {
				WalletAction.addRandomAsset(ft)
			}
		}
	}
	
	private func deleteRandomNonFungibleToken() async {
		await walletSvc.deleteRandomAsset(of: .nonFungibleToken)
		await loadWalletAssets()
	}
	
	
	private func deleteRandomFungibleToken() async {
		await walletSvc.deleteRandomAsset(of: .fungibleToken)
		await loadWalletAssets()
	}
	
	private func addRandomFungibleToken() async {
		let ft = await getRandom(asset: .fungibleToken) as? FungibleToken
		if let ft {
			await action {
				WalletAction.addRandomAsset(ft)
			}
		}
	}
	
	private func getRandom(asset type: WalletAssetType) async -> (any WalletAsset)? {
		return await walletSvc.getRandomAsset(ofCategory: type)
	}
	
	private func loadWalletAssets() async {
		let assets = await  walletSvc.loadWalletAssets()
		await action {
			WalletAction.fillStateWithWalletAssets(assets)
		}
	}
	
}
