import Swinject
import HapticsHelper
import RestClient

class DIContainerBuilder {
    public static func build() -> Container {
        let container = Container()
        utilsModule(container: container)
        settingsModule(container: container)
		mainModules(container: container)
        return container
    }

	private static func mainModules(container: Container) {
		container.register(IAppSaga.self) { (resolver: Resolver) -> IAppSaga in
			AppSaga()
		}
		.inObjectScope(.container)
		
		container.register(IWalletService.self) { (resolver: Resolver) -> IWalletService in
			WalletService(
				
			)
		}.inObjectScope(.container)
		
		container.register(IWalletSaga.self) { (resolver: Resolver) -> IWalletSaga in
			WalletSaga(
				walletService: resolver.resolve(IWalletService.self)!
			)
		}.inObjectScope(.container)
		
		
		container.register(IRestClient.self) { (resolver: Resolver) -> IRestClient in
			RestClient()
		}.inObjectScope(.container)
		

	}
	
    private static func utilsModule(container: Container) {
        
        container.register(IHapticEffectService.self) { (resolver: Resolver) -> IHapticEffectService in
            HapticEffectService()
        }
        .inObjectScope(.container)

    }

    private static func settingsModule(container: Container) {
        container.register(ISettingsService.self) { (resolver: Resolver) -> ISettingsService in
                    SettingsService()
                }
		.inObjectScope(.container)

        container.register(ISettingsSaga.self) { (resolver: Resolver) -> ISettingsSaga in
                    SettingsSaga(
                            settingsSvc: resolver.resolve(ISettingsService.self)!
                    )
                }
		.inObjectScope(.container)
    }

}
