import TonkUI

struct ContentContainer: View {
    internal let appStore: PerduxStore

	@ObservedObject private var navState: NavigationViewState
	@StateObject private var animationNamespaceStore: AnimationNamespaceState

	init(
		appStore: PerduxStore
	) {
		self.appStore = appStore
		self._navState = .init(initialValue: appStore.getViewState(NavigationViewState.self))
		self._animationNamespaceStore = StateObject(wrappedValue: AnimationNamespaceState())
	}
	
	
	@State private var currentPage: AppRootPage = .undefined
	@State private var undefinedStateIsActive = false
	@State private var appRootContainerIsActive = false
	
	
	var body: some View {
        Content()
			.onReceive(navState.$rootPage, perform: toggleAnimationContext)
    }

    @ViewBuilder
	private func Content() -> some View {
		VStack(spacing: 0) {
			if let rootPage = navState.rootPage {
				switch rootPage {
					case .undefined:
						Initialization()
							.extendingContent()
							.background(Color.tonSystemBackground)
					case .app:
						App()
							.background(Color.tonSystemBackground)
				}
			}
		}
		
		.sheet(item: $navState.modalSheet, content: modalPage)
		.fullScreenCover(item: $navState.modalPage, content: modalPage)
		.alert(item: $navState.alert, content: alert)
	}
}

extension ContentContainer {
	private func toggleAnimationContext(_ page: AppRootPage?) {
		guard let page else { return }
		withAnimation(.easeInOut(duration: 0.5)) {
			currentPage = page
			switch page {
				case .undefined:
					undefinedStateIsActive = true
					appRootContainerIsActive = false
				case .app:
					undefinedStateIsActive = false
					appRootContainerIsActive = true
			}
		}
	}
}

// modals
extension ContentContainer {
	
    @ViewBuilder
	private func modalPage(_ type: AppModalPage) -> some View {
		switch type {
			case .changelog:
				Text("hello")
					.tintColor(.accentColor)
					.alert(item: $navState.alert, content: alert)
		}
	}
}


// alerts
extension ContentContainer {
    func alert(_ type: AlertType) -> Alert {
//        switch type {
//        }
    }
}

// subpages
extension ContentContainer {
    private func Initialization() -> some View {
        ProgressView()
			.extendingContent()
    }

    private func App() -> some View {
		AppRootContainer(props: .init(isActiveInParentContainer: $appRootContainerIsActive))
            .environmentObject(appStore.getViewState(NavigationViewState.self))
            .environmentObject(appStore.getViewState(SettingsViewState.self))
			.environmentObject(appStore.getViewState(WalletDashboardViewState.self))
			.environmentObject(animationNamespaceStore)
    }
}
