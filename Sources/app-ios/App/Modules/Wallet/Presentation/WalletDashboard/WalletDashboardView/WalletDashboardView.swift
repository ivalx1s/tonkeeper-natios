import TonkUI


struct WalletDashboardView: View {
	@Binding private var isActiveInParentContainer: Bool
	@ObservedObject private var namespaceState: AnimationNamespaceState
	@ObservedObject private var walletDashboardViewState: WalletDashboardViewState
	@StateObject private var ls: LocalState
	@Environment(\.bounds) private var bounds
	@Environment(\.locale) private var locale
	@Namespace private var pageControl

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
	
	
	@State private var longestTabSelectorTextWidth: CGFloat? = 100
	@State private var tallestTabSelectorTextHeight: CGFloat?
	
	@State var longestPageWidth: CGFloat? = 0
	@State var tallestPageHeight: CGFloat? = 0
	
	
	var body: some View {
		Content()
			.safeAreaInset(edge: .top, spacing: 0) {
				topContent
			}
			.onPreferenceChange(TabSizeKey.self, perform: { sizes in
				guard sizes.count > 0 else {
					return
				}
				self.longestTabSelectorTextWidth = sizes.map { $0.width }.max()
				self.tallestTabSelectorTextHeight = sizes.map { $0.height }.max()
			})
			.onChange(of: activePageIdx) { idx in
				guard let idx else { return }
				// guard walletDashboardViewState.tokenLayout.asPages.count > 2 else { return }
				withAnimation {
					// pageTabControlProxy?.moveTo(idx)
				}
			}
	}
	
	@State private var activePageIdx: Int?
	@State private var pageHeight: CGFloat?
	
	@ViewBuilder
	private func Content() -> some View {
		ScrollView([.vertical], showsIndicators: false) {
			VStack(spacing: 0) {
				// only used to read coordinates of scroll view's first element
				Color.clear
					.frame(height: 0)
					.storingSize(in: $ls.contentRect, space: .named(ls.contentNameSpace))
				
				WalletBalance()
					.padding(.bottom, 34)
					.padding(.top, 28)
				
				WalletActionsControl()
					.padding(.bottom, 32)
				
				PageTabControl(walletDashboardViewState.tokenLayout, idx: $activePageIdx)
					.opacity(ls.pageTabControlSticked ? 0 : 1)
					.disabled(ls.pageTabControlSticked)
					.storingSize(in: $ls.pageTabControl, space: .named(ls.contentNameSpace), logToConsole: false)
				HPageView(alignment: .center, pageWidth: bounds.width, activePageIndex: $activePageIdx) {
//					.fungibleAggregation([.fungibleToken]),
//					.nonFungibleAggregation([.nonFungibleToken]),
//					.fungibleAggregation([.nonLiquidAsset]),
					ForEach(walletDashboardViewState.tokenLayout.asPages.numbered(startingAt: 0)) { tuple in
						Color.white.opacity(0.001)
							.overlay(alignment: .top) {
								DashboardPage(
									assetType: tuple.element,
									fungibleTokens: walletDashboardViewState.fungibleTokens,
									nonFungibleTokens: walletDashboardViewState.nonFungibleTokens,
									nonLiquidAsset: walletDashboardViewState.nonLiquidAssets
								)
							}
					}
				}
				.equalSizes()
				.onPreferenceChange(PageSizeKey.self, perform: { sizes in
					guard sizes.count > 0 else {
						return
					}
					self.longestPageWidth = sizes.map { $0.width }.max()
					
					if let maxHeight = sizes.map({ $0.height }).max() {
						self.tallestPageHeight = maxHeight
					}
				})
				.frame(height: tallestPageHeight)
				.offset(y: walletDashboardViewState.tokenLayout != .aggregated ? 0 : -1*ls.pageTabControl.height)
				
			}
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
	private func WalletBalance() -> some View {
		VStack(alignment: .center, spacing: 9) {
			HStack(spacing: 0) {
				Text("$")
					.padding(.trailing, 4)
					.font(.montserrat(.title))
					.foregroundColor(.tonPrimaryLabel)
				Text("28,947")
					.font(.montserrat(.title))
					.foregroundColor(.tonPrimaryLabel)
			}
			Text("EQF2…G21Z")
				.font(.montserrat(.subheadline))
				.foregroundColor(.tonSecondaryLabel)
		}
	}
	
	@ViewBuilder
	private func WalletActionsControl() -> some View {
		HStack(alignment: .bottom, spacing: 27) {
			WalletActionButton(iconName: "icon_buy", actionName: "Buy")
			WalletActionButton(iconName: "icon_send", actionName: "Send")
			WalletActionButton(iconName: "icon_receive", actionName: "Receive")
			WalletActionButton(iconName: "icon_sell", actionName: "Sell")
		}
	}
	
	@ViewBuilder
	private func WalletActionButton(iconName: String, actionName: String) -> some View {
		VStack(alignment: .center, spacing: 8) {
			Button(action: { } ) {
				Image(iconName)
			}
			.buttonStyle(.walletAction)
			Text(LocalizedStringKey(actionName))
				.font(.montserrat(.callout))
				.foregroundColor(.tonSecondaryLabel)
		}
	}
	
	@State private var pageTabControlProxy: PageViewProxy?
	@State private var activeTabIdx: Int?
	@ViewBuilder
	private func PageTabControl(_ tokenLayout: WalletDashboardView.TokenLayout, idx: Binding<Int?>) -> some View {
		PageViewReader { proxy in
			HPageView(alignment: .leading, pageWidth: longestTabSelectorTextWidth, spacing: 8, activePageIndex: $activeTabIdx) {
				//ScrollView(.horizontal, showsIndicators: false) {
				switch tokenLayout {
					case ._aggregated:
						EmptyView()
					case let ._discrete(assetTypes):
						PageTabSelector(assetTypes, idx: idx)
					case let ._hybrid(assetTypes):
						PageTabSelector(assetTypes, idx: idx)
						
				}
			}
			.onAppear {
				self.pageTabControlProxy = proxy
			}
			.offset(x: pageTabSelectorOffset)
			.padding(.vertical)
			.extendingContent(.horizontal)
			.frame(height: 70)
			.safeAreaInset(edge: .leading) {
				Color.clear
					.frame(
						width: walletDashboardViewState.tokenLayout.asPages.count > 2
						? 16
						: 0,
						height: 0
					)
			}
	    }
	}
	
	@ViewBuilder
	private func PageTabSelector(_ assetTypes: Array<WalletDashboardView.AggregatedAssetType>, idx: Binding<Int?>) -> some View {
		ForEach(assetTypes.numbered(startingAt: 0)) { numberedAssetTypes in
			ForEach(numberedAssetTypes.element.wrappedValue) { assetType in
				VStack(alignment: .center, spacing: 11) {
					Button(action: {
						idx.wrappedValue = numberedAssetTypes.number
					}) {
						Text(LocalizedStringKey(assetType.rawValue))
						PageSelectionIndicator()
							.opacity(idx.wrappedValue == numberedAssetTypes.number ? 1 : 0)
							.animation(.easeInOut(duration: 0.3), value: idx.wrappedValue == numberedAssetTypes.number)
					}
					.buttonStyle(.pageSelector(isSelected: idx.wrappedValue == numberedAssetTypes.number))
				}
				.overlay(
					GeometryReader { proxy in
						Color.clear.preference(key: TabSizeKey.self, value: [proxy.size])
					}
				)
			}
			
		}
	}
	
	@ViewBuilder
	private func PageSelectionIndicator() -> some View {
		RoundedRectangle(cornerRadius: 3, style: .continuous)
			.frame(width: 24, height: 3)
			.foregroundColor(.tonBlue)
	}
	
	
//		.fungibleAggregation([.fungibleToken]),
	@ViewBuilder
	private func DashboardPage(
		assetType: AggregatedAssetType,
		fungibleTokens: [Numbered<FungibleToken>],
		nonFungibleTokens: [NonFungibleToken],
		nonLiquidAsset: [NonLiquidAsset]
	) -> some View {
		switch assetType {
			case let .fungibleAggregation(walletAssetTypes):
				VStack(spacing: 32) {
					ForEach(walletAssetTypes) { type in
						switch type {
							case .fungibleToken:
								FungibleTokenList(tokens: fungibleTokens)
							case .nonFungibleToken:
								NonFungibleTokenGrid(tokens: nonFungibleTokens)
							case .nonLiquidAsset:
								NonLiquidAssetList(assets: nonLiquidAsset)
						}
					}
				}
			case let .nonFungibleAggregation(walletAssetTypes):
				VStack {
					ForEach(walletAssetTypes) { type in
						switch type {
							case .fungibleToken:
								FungibleTokenList(tokens: fungibleTokens)
							case .nonFungibleToken:
								NonFungibleTokenGrid(tokens: nonFungibleTokens)
							case .nonLiquidAsset:
								NonLiquidAssetList(assets: nonLiquidAsset)
						}
					}
				}
		}
	}
	
	@ViewBuilder
	private func NonFungibleTokenGrid(tokens: [NonFungibleToken]) -> some View {
		if tokens.count > 0 {
			NftGrid(nfts: tokens)
				.padding(.horizontal)
				.overlay(
					GeometryReader { proxy in
						Color.clear.preference(key: PageSizeKey.self, value: [proxy.size])
					}
				)
		}
	}
	
	@ViewBuilder
	private func FungibleTokenList(tokens: [Numbered<FungibleToken>]) -> some View {
		if tokens.count > 0 {
			let lastElementIdx = tokens.count - 1
			LazyVStack(spacing: 0) {
				ForEach(tokens) { tuple in
					FungibleTokenListRow(
						element: tuple.element,
						idx: tuple.number,
						isFirst: tuple.number == 0,
						isLast: tuple.number == lastElementIdx
					)
				}
			}
			.overlay(
				GeometryReader { proxy in
					Color.clear.preference(key: PageSizeKey.self, value: [proxy.size])
				}
			)
		}
	}

	
	@ViewBuilder
	private func NonLiquidAssetList(assets: [NonLiquidAsset]) -> some View {
		if assets.count > 0 {
			let lastElementIdx = assets.count - 1
			VStack(spacing: 0) {
				ForEach(assets.numbered(startingAt: 0)) { tuple in
					NonLiquidTokenListRow(
						element: tuple.element,
						idx: tuple.number,
						isFirst: tuple.number == 0,
						isLast: tuple.number == lastElementIdx
					)
				}
			}
			.overlay(
				GeometryReader { proxy in
					Color.clear.preference(key: PageSizeKey.self, value: [proxy.size])
				}
			)
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
			Button(action: { }) {
				Image("icon_qrscanner")
					.resizable()
					.frame(width: 22, height: 22)
			}
			.padding(.trailing, 21)
		}
		.offset(walletDashboardViewState.tokenLayout != .aggregated ? ls.navbarTitleYOffset : .zero)
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
		VStack(spacing: 0) {
			if walletDashboardViewState.tokenLayout != .aggregated {
				PageTabControl(walletDashboardViewState.tokenLayout, idx: $activePageIdx)
					.offset(y: ls.pageTabControl.height)
					.opacity(ls.pageTabControlSticked ? 1 : 0)
					.disabled(!ls.pageTabControlSticked)
			}
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

extension WalletDashboardView {
	private var pageTabSelectorOffset: CGFloat {
		walletDashboardViewState.tokenLayout.asPages.count > 2
		? 0
		: (bounds.width/4)
	}
}


struct PageSelectorButtonStyle: ButtonStyle {
	let isSelected: Bool
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.fixedSize(horizontal: true, vertical: false)
			.opacity(configuration.isPressed ? 0.8 : 1)
			.scaleEffect(configuration.isPressed ? 0.97 : 1)
			.foregroundColor(isSelected ? .tonPrimaryLabel : .tonSecondaryLabel)
			.font(.montserrat(.headline))
			.fontWeight(.semibold)
			.contentShape(Rectangle())
			.animation(.easeInOut(duration: 0.3), value: configuration.isPressed)
	}
}

struct WalletActionButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		Circle()
			.foregroundColor(.tonSecondarySystemBackground)
			.frame(width: 44, height: 44)
			.overlay(alignment: .center) {
				configuration.label
					.frame(width: 15, height: 15)
			}
			.scaleEffect(configuration.isPressed ? 1.3 : 1)
			.contentShape(Circle())
			.animation(.easeInOut(duration: 0.3), value: configuration.isPressed)
	}
}

extension ButtonStyle where Self == PageSelectorButtonStyle {
	static func pageSelector(isSelected: Bool) -> PageSelectorButtonStyle {
		PageSelectorButtonStyle(isSelected: isSelected)
	}
}


extension ButtonStyle where Self == WalletActionButtonStyle {
	static var walletAction: WalletActionButtonStyle {
		WalletActionButtonStyle()
	}
}


struct PageSizeKey: PreferenceKey {
	static let defaultValue: [CGSize] = []
	static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
		value.append(contentsOf: nextValue())
	}
}

struct TabSizeKey: PreferenceKey {
	static let defaultValue: [CGSize] = []
	static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
		value.append(contentsOf: nextValue())
	}
}
