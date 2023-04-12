protocol IAppSaga: PerduxSaga {
	
}

final class AppSaga: IAppSaga {
	
	init(

	) {

	}
	
	func apply(_ effect: PerduxEffect) async {
		switch effect as? AppSideEffect {
			case .none: break
			case .setupContext:
				await setupContext()
		}
	}
	
	private func setupContext() async {
		await actions {
			SettingsSideEffect.obtainSettings
			NavigationAction.setRootPage(.app)
			NavigationAction.setMainPage(.wallet(subpage: .dashboard))
		}
	}
}
