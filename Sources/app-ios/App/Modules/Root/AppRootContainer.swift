import TonkUI

extension AppRootContainer {
	struct Props: DynamicProperty {
		@Binding var isActiveInParentContainer: Bool
	}
}

struct AppRootContainer: View {
	private let props: Props
	
	init(props: Props) {
		self.props = props
	}
	
	@Environment(\.safeAreaEdgeInsets) private var safeAreaEdgeInsets
	@EnvironmentObject private var navState: NavigationViewState
	
	@Namespace private var rootAnimation
	
	@State private var currentPage: MainPage?
	
	@State private var walletPageIsPresentInRootContainer = false
	@State private var settingsPageIsPresentInRootContainer = false
	
	@State private var walletDashboardPageIsActive = false
	@State private var walletScannerPageIsActive = false
	
	
	var body: some View {
		Content()
			.transition(.scale(scale: 1))
			.task(loadData)
			.onChange(of: navState.mainPage, perform: internalSetPage)
	}
	
	@ViewBuilder
	private func Content() -> some View {
		TabsContent()
			.navBar(middle: tabBar, edge: .bottom)
			.propagatingContentFrame(coordinateSpace: .named(name: "contentFrame"))
	}
	
	@ViewBuilder
	private func TabsContent() -> some View {
		switch currentPage {
			case .none:
				Text("")
					.extendingContent()
					//.transition(.scale(scale: 1))
			case .undefined:
				Text("")
					.extendingContent()
					//.transition(.scale(scale: 1))
				
			case let .wallet(subpage):
				WalletDashboard(subpage)
					//.transition(.scale(scale: 1))
				
			case  .settings:
				SettingsView()
					//.transition(.scale(scale: 1))
				
			case .activity:
				Text("")
					.extendingContent()
			case .some(.browser):
				Text("")
					.extendingContent()
		}
	}
	
	@State private var tabbarSize: CGRect = .zero
	
	
	#warning("implement using native TabView")
	@ViewBuilder
	private var tabBar: some View {
		if let mainPage = navState.mainPage {
			BottomNavigation(
				props: .init(
					activeItemId: mainPage.id,
					items: [
						.wallet(subpage: .dashboard),
						.activity,
						.browser,
						.settings(subpage: .general),
					]
						.map {
							BottomNavigation.buildItem(for: $0)
						}
				)
			)
			.storingSize(in: $tabbarSize)
			.offset(y: navState.bottomNavShown ? 0 : tabbarSize.height + safeAreaEdgeInsets.bottom)
			.animation(.easeInOut(duration: 0.3), value: navState.bottomNavShown)
		}
	}
	
	
	@Sendable
	private func loadData() async {
/*
		await actions {
			// trigger data fetching
		}
 */
	}
	
	@ViewBuilder
	private func WalletDashboard(_ subpage: MainPage.Wallet) -> some View {
		WalletDashboardContainer(
			isPresentInRootContainer: $walletPageIsPresentInRootContainer,
			props: .init(
				isPresentInRootContainer: $walletPageIsPresentInRootContainer,
				walletDashboardPageIsActiveInParentContainer: $walletDashboardPageIsActive,
				walletScannerPageIsActiveIsPresentInParentContainer: $walletScannerPageIsActive,
				subpage: subpage
			)
		)
	}
	
	private func internalSetPage(_ page: MainPage?) {
		guard let page else {
			return
		}
		withAnimation(.easeInOut(duration: 0.5)) { //(page.animation) {
			self.currentPage = page
			switch page {
				case .undefined:
					self.walletPageIsPresentInRootContainer = false
					self.settingsPageIsPresentInRootContainer = false
					
					self.walletScannerPageIsActive = false
					self.walletDashboardPageIsActive = false
				case let .wallet(subpage):
					self.walletPageIsPresentInRootContainer = true
					self.settingsPageIsPresentInRootContainer = false
					
//			        don't remember whether we need to set these to false
//					self.walletScannerPageIsActive = true
//					self.walletDashboardPageIsActive = false
					
					switch subpage {
						case .scanner:
							self.walletScannerPageIsActive = true
							self.walletDashboardPageIsActive = false
						case .dashboard:
							self.walletScannerPageIsActive = false
							self.walletDashboardPageIsActive = true
					}
				case .settings:
					self.walletPageIsPresentInRootContainer = false
					self.settingsPageIsPresentInRootContainer = true
					
					self.walletDashboardPageIsActive = false
					self.walletScannerPageIsActive = false
				case .activity:
					break
				case .browser:
					break
			}
		}
	}
}
