import TonkUI


struct WalletDashboardView: View {
	@Binding private var isActiveInParentContainer: Bool
	@ObservedObject private var namespaceState: AnimationNamespaceState
	@ObservedObject private var walletDashboardViewState: WalletDashboardViewState
	@StateObject private var ls: LocalState
	@Environment(\.bounds) private var bounds

	let props: Props
	let actions: Actions
	
	init(isActiveInParentContainer: Binding<Bool>, props: Props, actions: Actions, states: States) {
		self.props = props
		self.actions = actions
		self.namespaceState = states.namespaceState
		self.walletDashboardViewState = states.dashboardState
		self._ls = StateObject(wrappedValue: LocalState())
		self._isActiveInParentContainer = isActiveInParentContainer
	}
	
	
	
	
	var body: some View {
		Content()
			.safeAreaInset(edge: .top, spacing: 0) {
				topContent
			}
	}
	
	@State private var activePageIdx: Int?
	@State private var pageHeight: CGFloat?
	
	@ViewBuilder
	private func Content() -> some View {
		ScrollView([.vertical], showsIndicators: false) {
			VStack(spacing: 0) {
				Color.clear
					.frame(height: 10)
					.storingSize(in: $ls.contentRect, space: .named(ls.contentNameSpace))
				PageTabControl(walletDashboardViewState.tokenLayout, idx: $activePageIdx)
					.opacity(ls.pageTabControlSticked ? 0 : 1)
					.disabled(ls.pageTabControlSticked)
					.storingSize(in: $ls.pageTabControl, space: .named(ls.contentNameSpace), logToConsole: false)
				HPageView(alignment: .center, pageWidth: bounds.width, activePageIndex: $activePageIdx) {
					ForEach(walletDashboardViewState.tokenLayout.asPages.numbered(startingAt: 0)) { tuple in
						Color.white.opacity(0.001)
							.overlay(alignment: .top) {
								EmptyView()
								//Text(page.id)
								DashboardPage(idx: tuple.number)
							}
					}
				}
				.frame(height: pageHeight)
				.offset(y: walletDashboardViewState.tokenLayout != .aggregated ? 0 : -1*ls.pageTabControl.height)
				
			}
			Color.red
				.opacity(0.8)
		}
		.coordinateSpace(name: ls.contentNameSpace)
		.onChange(of: activePageIdx) { newIdx in
			// used for debugging, to be deleted
			guard let newIdx else { return }
			pageHeight = 1000
			switch newIdx {
				case 0:
					break
				case 1:
					break
				default:
					break
			}
		}
	}
	
	@ViewBuilder
	private func PageTabControl(_ tokenLayout: WalletDashboardView.TokenLayout, idx: Binding<Int?>) -> some View {
		ScrollView(.horizontal, showsIndicators: false) {
			switch tokenLayout {
				case ._aggregated:
					EmptyView()
				case let ._discrete(assetTypes):
					PageTabSelector(assetTypes, idx: idx)
				case let ._hybrid(assetTypes):
					PageTabSelector(assetTypes, idx: idx)
			}
		}
		.safeAreaInset(edge: .leading) {
			Color.clear
				.frame(width: 8, height: 0)
		}
		.safeAreaInset(edge: .trailing) {
			Color.clear
				.frame(width: 8, height: 0)
		}
		.padding(.vertical)
		.extendingContent(.horizontal)
	}
	
	@ViewBuilder
	private func PageTabSelector(_ assetTypes: Array<WalletDashboardView.AggregatedAssetType>, idx: Binding<Int?>) -> some View {
		HStack {
			ForEach(assetTypes.numbered(startingAt: 0)) { numberedAssetTypes in
				ForEach(numberedAssetTypes.element.wrappedValue) { assetType in
					Button(action: { idx.wrappedValue = numberedAssetTypes.number }) {
						Text(LocalizedStringKey(assetType.rawValue))
							.font(.montserrat(.title3))
					}
				}
				
			}
		}
	}
	
	@ViewBuilder
	private func DashboardPage(idx: Int) -> some View {
		switch idx {
			case 0:
				DashboardPage1()
			case 1:
				DashboardPage2()
			case 2:
				DashboardPage3()
			default:
				EmptyView()
		}
	}
	
	@ViewBuilder
	private func DashboardPage1() -> some View {
		Color.red
			.frame(height: 400)
	}
	
	@ViewBuilder
	private func DashboardPage2() -> some View {
		Color.green
			.frame(height: 200)
	}
	
	@ViewBuilder
	private func DashboardPage3() -> some View {
		Color.yellow
			.frame(height: 200)
	}
	
	@ViewBuilder
	private var topContent: some View {
		VStack(spacing: 0) {
			HStack(spacing: 0) {
				Spacer(minLength: 0)
				WalletDashboardTitle()
				Spacer(minLength: 0)
			}
//			.transition(
//				.move(edge: .top).combined(with: .opacity),
//				withAnimation: .easeInOut,
//				isPresentInParentContainer:  $isActiveInParentContainer
//			)
			.offset(walletDashboardViewState.tokenLayout != .aggregated ? ls.navbarTitleYOffset : .zero)
			.overlay(alignment: .bottom) {
				PageTabControlInNavbar()
					.offset(ls.pageTabControlYOffset)
			}
			.overlay(navBarButtons, alignment: .center)
		}
		.background(navbarMaterial)
//		.border(.yellow)
	}
	
	@ViewBuilder
	private var navbarMaterial: some View {
		ZStack {
			Color
				.tonSystemBackground
				.ignoresSafeArea()
			VStack(spacing: 0) {
				Spacer()
				Divider()
					.opacity(0.8)
			}
		}
			.opacity(ls.navBarBgOpacity)
			//.animation(.linear(duration: 0.15), value: ls.navBarBgOpacity)
	}
	
	@ViewBuilder
	private var navBarButtons: some View {
		HStack {
			Spacer()
		}
	}
	
	@ViewBuilder
	private func WalletDashboardTitle() -> some View {
		Text("Wallet")
			.font(.montserrat(.title2))
			.fontWeight(.bold)
			.extendingContent(.horizontal)
		     // due to a bug in swiftui,
		     // without explicit frame text breaks
		     // y-origin of a scroll view inner coordinate space
			.frame(height: ls.navbarHeight)
	}
	
	@ViewBuilder
	private func PageTabControlInNavbar() -> some View {
		if walletDashboardViewState.tokenLayout != .aggregated {
			PageTabControl(walletDashboardViewState.tokenLayout, idx: $activePageIdx)
				.offset(y: ls.pageTabControl.height)
				.opacity(ls.pageTabControlSticked ? 1 : 0)
				.disabled(!ls.pageTabControlSticked)
		}
	}

	
}


extension WalletDashboardView {
	struct Props: DynamicProperty {
		@Binding var isActiveInParentContainer: Bool
	}
	
	struct Actions {
		
	}
	
	struct States: DynamicProperty {
		let namespaceState: AnimationNamespaceState
		let dashboardState: WalletDashboardViewState
	}
}
