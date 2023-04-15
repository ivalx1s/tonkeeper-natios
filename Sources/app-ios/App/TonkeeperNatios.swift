import TonkUI
import SandboxPermissions

@_exported import Perdux
@_exported import Logger
@_exported import SwiftPlus
@_exported import FoundationPlus


@main
struct TonkeeperNatios: App {
    public private(set) static var appStore: PerduxStore!
    public private(set) static var rootSaga: PerduxRootSaga!
	
	@Environment(\.scenePhase) var scenePhase

    init() {
        let time = measure {
			TonkeeperNatios.registerFonts()
			TonkeeperNatios.configureIoC()
			TonkeeperNatios.configureAppStore()
			TonkeeperNatios.configureRootSaga()
        }
        log("app initialization took: \(time)", category: .performance)
    }

    var body: some Scene {
        WindowGroup {
            ContentContainer(
				appStore: TonkeeperNatios.appStore
            )
            .tintColor(.accentColor)
			.task(configureAppearance)
			.task(generateRandomUUIDs)
			.task(setupAppContext)
        }
		.onChange(of: scenePhase, perform: updateSceneContext)
    }
	
	private func updateSceneContext(_ scenePhase: ScenePhase) {
		switch scenePhase {
			case .active:
				break
			case .background:
				break
			case .inactive:
				break
			@unknown default:
				break
		}
	}

	@MainActor
    static private func registerFonts() {
		registerTonkFonts()
    }

	
	@MainActor
    static private func configureIoC() {
        ObjectFactory.initialize(with: DIContainerBuilder.build())
    }

	
	@MainActor
    static private func configureAppStore() {
		self.appStore = .init()
		let sandboxPermissionsManager = SandboxPermissionsManager()
		let navigationState = NavigationState()
		
		let settingsState = SettingsState(
			sandboxPermissions: sandboxPermissionsManager
		)
		
		let walletState = WalletState()

        //business states
        appStore.connectState(state: navigationState)
        appStore.connectState(state: settingsState)
		appStore.connectState(state: walletState)

        //view states
		
		let navigationViewState = NavigationViewState(
			navState: navigationState
		)
		
		let settingsViewState = SettingsViewState(
			settingsState: settingsState
		)
		
		let walletDashboardViewState = WalletDashboardViewState(
			walletState: walletState
		)
		
		appStore.connectViewState(state: settingsViewState)
		appStore.connectViewState(state: walletDashboardViewState)
		appStore.connectViewState(state: navigationViewState)
    }

	
	@MainActor
    static private func configureRootSaga() {
        rootSaga = .init()
        rootSaga.add(saga: F.get(type: ISettingsSaga.self)!)
		rootSaga.add(saga: F.get(type: IAppSaga.self)!)
		rootSaga.add(saga: F.get(type: IWalletSaga.self)!)
    }
	
	

	@Sendable
	private func setupAppContext() {
		performAsync(withPriority: .userInitiated) {
			SettingsSideEffect.obtainSettings
		}
		
		performAsync {
			AppSideEffect.setupContext
		}
		
		performAsync {
			WalletSideEffect.loadWalletAssets
		}
		
    }
	
	
	@Sendable
	private func generateRandomUUIDs() async {
		#if DEBUG
		Task(priority: .low) {
			log("a bunch of random UUIDs")
			for _ in 0...10 {
				print(UUID().uuidString)
			}
		}
		#endif
	}

	@Sendable
	private func configureAppearance() async {
		Task { @MainActor in
			UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.accentColor)
		}
    }
}
