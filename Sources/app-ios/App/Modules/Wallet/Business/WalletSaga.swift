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
			case .none:
				break
		}
	}
	
	private func loadWalletAssets() async {
		let assets = walletSvc.loadWalletAssets()
		await action {
			WalletAction.fillStateWithWalletAssets(assets)
		}
	}
	
}
