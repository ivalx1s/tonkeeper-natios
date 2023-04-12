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
			.navBar(middle: topContent)
	}
	
	@ViewBuilder
	private func Content() -> some View {
		ScrollView {
			Color.clear
				.frame(height: 200)
				.storingContentFrame
				.storingSize(in: $ls.contentRect, space: .named(ls.contentNameSpace))
			HPageView(alignment: .center, pageWidth: bounds.width) {
				ForEach(1..<3) { idx in
					DashboardPage(idx: idx)
				}
			}
			.frame(height: 2000)
			.border(.white)
			Color.red
				.opacity(0.8)
		}
		.coordinateSpace(name: ls.contentNameSpace)
	}
	
	@ViewBuilder
	private func DashboardPage(idx: Int) -> some View {
		switch idx {
			case 1:
				DashboardPage1()
			case 2:
				DashboardPage2()
			default:
				EmptyView()
		}
	}
	
	@ViewBuilder
	private func DashboardPage1() -> some View {
		Color.blueTon
			.opacity(0.4)
			.frame(height: 400)
	}
	@ViewBuilder
	private func DashboardPage2() -> some View {
		Color.blueTon
			.opacity(0.4)
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
			.transition(
				.move(edge: .top).combined(with: .opacity),
				withAnimation: .easeInOut,
				isPresentInParentContainer:  $isActiveInParentContainer
			)
			.overlay(navBarButtons, alignment: .center)
		}
		.background(navbarMaterial)
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
		     // due to a bug in swiftui,
		     // without explicit frame text breaks
		     // y-origin of a scroll view inner coordinate space
			.frame(height: ls.navbarHeight)
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


extension WalletDashboardView {
	class LocalState: ObservableObject {
		let contentNameSpace = "walletDashboard"
		@Published var navBarBgOpacity: CGFloat = 0
		@Published var contentRect: CGRect = .zero
		@Published var navbarHeight: CGFloat = 64
		
		init() {
			bindFields()
		}
		
		private func bindFields() {
			$contentRect
				.map {
					switch $0.origin.y {
						case ..<0: return 1
						case 0...: return 0
						default: return 0
					}
				}
				.removeDuplicates()
				.assign(to: &$navBarBgOpacity)
		}
	}
}
