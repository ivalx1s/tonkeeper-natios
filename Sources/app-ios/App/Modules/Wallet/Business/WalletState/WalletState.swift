import Combine



extension WalletState {
	func reduce(with action: WalletAction) async {
		switch action {
			case let .fillStateWithWalletAssets(assets):
				self._walletAssets = assets
		}
	}
}


final class WalletState: PerduxState {

	private var _walletAssets: [any WalletAsset] = [] {
		didSet {
			walletAssetsSub.send(_walletAssets)
		}
	}
	
	private let walletAssetsSub: PassthroughSubject<[any WalletAsset], Never> = .init()
	public var walletAssets: AnyPublisher<[any WalletAsset], Never> {
		walletAssetsSub
			.eraseToAnyPublisher()
	}

	func reduce(with action: PerduxAction) async {
		switch action as? WalletAction {
			case .none:
				break
			case let .some(action):
				await reduce(with: action)
		}
	}
	
	
	
	init(
		
	) {
		
	}
	
	
	
	func cleanup() async {
		fatalError()
	}
	
}
