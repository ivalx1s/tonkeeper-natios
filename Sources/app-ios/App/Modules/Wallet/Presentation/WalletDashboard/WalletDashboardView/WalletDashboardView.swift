import TonkUI


struct WalletDashboardView: View {
	@Binding private var isActiveInParentContainer: Bool
	@ObservedObject private var namespaceState: AnimationNamespaceState
	@ObservedObject private var walletDashboardViewState: WalletDashboardViewState
	@StateObject private var ls: LocalState
	@Environment(\.bounds) private var bounds
	@Environment(\.locale) private var locale
	@Namespace private var pageControl
	@Namespace private var page

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
	
	@State var longestTabWidth: CGFloat? = 0
	@State var tallestPageHeight: CGFloat = 0
	@State private var pageTabSelectorYOriginCollected = false
	@State private var pageTabSelectorBottomPaddingYOriginCollected = false
	
	@State private var pageOffset: CGFloat = .zero
	
	@State private var activePageIdx: Int? = 0
	@State private var tabSelectorIsVisible = false
	@State private var scrollProxy: ScrollViewProxy?
	
	
	
	var totalTabsWidth: Binding<CGFloat?> {
		.init(get: {
			guard let longestTabWidth else { return .none }
//			print("longestTabWidth: \(longestTabWidth)")
			return longestTabWidth * CGFloat(walletDashboardViewState.tokenLayout.asPages.count)
			
		}, set: { _ in })
	}
	
	
	var body: some View {
	//	Self._printChanges()
		return Content()
			.onReceive(walletDashboardViewState.$tokenLayout) { tokenLayout in
				//withAnimation(.linear(duration: 0.3)) {
					if tokenLayout == .aggregated {
						activePageIdx = 0
					}
					pageOffset = tokenLayout == .aggregated ? -1*ls.pageTabControlSize.height : 0
//					print("pageOffset: \(pageOffset)")
					tabSelectorIsVisible = tokenLayout == .aggregated ? false : true
				//}
			}
			.onAppear {
				tabSelectorIsVisible = walletDashboardViewState.tokenLayout != .aggregated ? true : false
			}
			.safeAreaInset(edge: .top, spacing: 0) {
				topContent
			}
			.onPreferenceChange(TabSizeKey.self, perform: { sizes in
				guard sizes.count > 0 else {
					return
				}
				self.longestTabSelectorTextWidth = sizes.map { $0.width }.max()
//				self.tallestTabSelectorTextHeight =
			})
			.onChange(of: activePageIdx) { idx in
				// guard let idx else { return }
				// guard walletDashboardViewState.tokenLayout.asPages.count > 2 else { return }
				// withAnimation {
				// pageTabControlProxy?.moveTo(idx)
				// }
			}
			.onPreferenceChange(PageTabSelectorFrameKey.self, perform: { frames in
				guard frames.isNotEmpty else { return }
				if pageTabSelectorYOriginCollected.not {
					pageTabSelectorYOriginCollected = true
					LocalState.pageTabControlInitialYOrigin = frames[0].origin.y
					ls.pageTabControlSize = frames[0].size
				}
			})
			.onPreferenceChange(PageTabControlBottomPaddingFrameKey.self, perform: { frames in
				guard frames.isNotEmpty else { return }
				if pageTabSelectorBottomPaddingYOriginCollected.not {
					pageTabSelectorBottomPaddingYOriginCollected = true
					LocalState.pageTabControlBottomPaddingInitialYOrigin = frames[0].origin.y
				}
			})
			.onPreferenceChange(TabSizeKey.self, perform: { sizes in
				guard sizes.count > 0 else {
					return
				}
				self.longestTabWidth = sizes.map {
//					print("width: \($0.width)")
					return $0.width
				}.max()
//				print("longestTabWidth!!!: \(self.longestTabWidth)")
			})
			.onChange(of: activePageIdx) { idx in
				guard ls.conditions.pageTabControlSticked else { return }
				delay(for: 0.2) {
					withAnimation(.easeInOut(duration: 0.3)) {
					//	scrollProxy?.scrollTo("PageTabControlBottomPadding", anchor: .top)
					}
				}
			}
	}
	
//	private var scrollViewAxes: Axis.Set {
//		if ls.conditions.pageNavbarContact {
//			return []
//		} else {
//			return .vertical
//		}
//	}
	
	@ViewBuilder
	private func Content() -> some View {
		ScrollView(.vertical, showsIndicators: false) {
			ScrollViewReader { proxy in
				VStack(spacing: 0) {
					// only used to read coordinates of scroll view's first element
					Color.clear
						.frame(height: 0)
					
					
					WalletBalance()
						.padding(.bottom, 34)
						.padding(.top, 28)
					
					
					
					WalletActionsControl()
						.padding(.bottom, 32)
					
					PageTabControl(walletDashboardViewState.tokenLayout, activePageIdx: $activePageIdx, longestTabSelectorTextWidth: longestTabSelectorTextWidth, totalTabsWidth: totalTabsWidth, pageTabSelectorOffset: pageTabSelectorOffset)
						.opacity(ls.conditions.pageTabControlSticked ? 0 : 1)
						.opacity(tabSelectorIsVisible ? 1 : 0)
						.frame(width: bounds.width, height: 70)
						.disabled(ls.conditions.pageTabControlSticked)
						.overlay(
							GeometryReader { proxy in
								Color.clear.preference(key: PageTabSelectorFrameKey.self, value: [proxy.frame(in: .named(ls.contentNameSpace))])
							}
						)
					/* // continue experimentation with TabView-based paging behavior instead of HPageView
					 TabView {
					 
					 }
					 .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
					 */
					Color.clear
						.frame(height: 16)
						.overlay(
							GeometryReader { proxy in
								Color.clear.preference(key: PageTabControlBottomPaddingFrameKey.self, value: [proxy.frame(in: .named(ls.contentNameSpace))])
							}
						)
						.id("PageTabControlBottomPadding")
				
					Color.clear
						.frame(height: tallestPageHeight + pageOffset)
						.overlay(
							VStack(spacing: 0) {
								SmartPager()
								Spacer(minLength: 0)
							}
						)
					
					
						//.offset(y: pageOffset)
					.onPreferenceChange(PageSizeKey.self, perform: { sizes in
						guard sizes.count > 0 else {
							return
						}
						if let maxHeight = sizes.map({ $0.height }).max() {
							self.tallestPageHeight = maxHeight
						}
					})
				}
				.storingSize(in: ls.rectSubject, onQueue: ls.queue, space: .named(ls.contentNameSpace), logToConsole: false)
				.onAppear {
					DispatchQueue.main.async {
						scrollProxy = proxy
					}
				}
			}
		}
		.coordinateSpace(name: ls.contentNameSpace)
	}
	
	@ViewBuilder
	private func SmartPager() -> some View {
		if ls.conditions.pageNavbarContact {
			TabView {
				ForEach(walletDashboardViewState.tokenLayout.asPages) { aggregatedType in
					ScrollView([]) {
						VStack(spacing: 0) {
							DashboardPage(
								assetType: aggregatedType.element,
								fungibleTokens: walletDashboardViewState.fungibleTokens,
								nonFungibleTokens: walletDashboardViewState.nonFungibleTokens,
								nonLiquidAsset: walletDashboardViewState.nonLiquidAssets,
								pageIdx: aggregatedType.number
							)
							.matchedGeometryEffect(id: aggregatedType.id, in: page)
						}
						.border(.red)
					}
				}
			}
			.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
			.frame(height: bounds.height - 150)
			.border(.green)
		} else {
			HPageView(alignment: .center, pageWidth: bounds.width, activePageIndex: $activePageIdx) {
				ForEach(walletDashboardViewState.tokenLayout.asPages) { aggregatedType in
					VStack(spacing: 0) {
						DashboardPage(
							assetType: aggregatedType.element,
							fungibleTokens: walletDashboardViewState.fungibleTokens,
							nonFungibleTokens: walletDashboardViewState.nonFungibleTokens,
							nonLiquidAsset: walletDashboardViewState.nonLiquidAssets,
							pageIdx: aggregatedType.number
						)
						.matchedGeometryEffect(id: aggregatedType.id, in: page)
						Spacer()
					}
				}
			}
			.frame(height: tallestPageHeight + pageOffset)
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
			WalletActionButton(iconName: "icon_buy", actionName: "Buy") {
				await action {
					WalletSideEffect.addRandomFungibleToken
				}
			}
			WalletActionButton(iconName: "icon_send", actionName: "Send") {
				
			}
			WalletActionButton(iconName: "icon_receive", actionName: "Receive") {
				
			}
			WalletActionButton(iconName: "icon_sell", actionName: "Sell") {
				await action {
					WalletSideEffect.deleteRandomFungibleToken
				}
			}
		}
	}
	
	@ViewBuilder
	private func WalletActionButton(iconName: String, actionName: String, action: @escaping () async -> Void) -> some View {
		VStack(alignment: .center, spacing: 8) {
			AsyncButton(action: action) {
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
	private func DashboardPage(
		assetType: AssetPage,
		fungibleTokens: [Numbered<FungibleToken>],
		nonFungibleTokens: [Numbered<NonFungibleToken>],
		nonLiquidAsset: [Numbered<NonLiquidAsset>],
		pageIdx: Int
	) -> some View {
		switch assetType {
			case let .page(walletAssetTypes):
				LazyVStack(spacing: 32) {
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
				.id(pageIdx)
				.overlay(
					GeometryReader { proxy in
						Color.clear.preference(key: PageSizeKey.self, value: [proxy.size])
					}
				)
		}
	}
	
	@ViewBuilder
	private func NonFungibleTokenGrid(tokens: [Numbered<NonFungibleToken>]) -> some View {
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
				ForEach(tokens, id: \.element.id) { tuple in
					FungibleTokenListRow(
						element: tuple.element,
						idx: tuple.number,
						isFirst: tuple.number == 0,
						isLast: tuple.number == lastElementIdx
					)
					.id(tuple.id)
					// debug view re-renders
//					.overlay(
//						Text("\(Int.random(in: 1...1000))")
//							.font(.largeTitle)
//					)
				}
			}
		}
	}

	
	@ViewBuilder
	private func NonLiquidAssetList(assets: [Numbered<NonLiquidAsset>]) -> some View {
		if assets.count > 0 {
			let lastElementIdx = assets.count - 1
			LazyVStack(spacing: 0) {
				ForEach(assets) { tuple in
					NonLiquidTokenListRow(
						element: tuple.element,
						idx: tuple.number,
						isFirst: tuple.number == 0,
						isLast: tuple.number == lastElementIdx
					)
				}
			}
//			.overlay(
//				GeometryReader { proxy in
//					Color.clear.preference(key: PageSizeKey.self, value: [proxy.size])
//				}
//			)
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
			.offset(y: walletDashboardViewState.tokenLayout != .aggregated ? ls.conditions.navbarTitleYOffset : .zero)
			.overlay(alignment: .bottom) {
				VStack(spacing: 0) {
					if walletDashboardViewState.tokenLayout != .aggregated {
						PageTabControl(walletDashboardViewState.tokenLayout, activePageIdx: $activePageIdx, longestTabSelectorTextWidth: longestTabSelectorTextWidth, totalTabsWidth: totalTabsWidth, pageTabSelectorOffset: pageTabSelectorOffset)
							.offset(y: ls.conditions.pageTabControlYOffset)
							.opacity(ls.conditions.pageTabControlSticked ? 1 : 0)
							.disabled(!ls.conditions.pageTabControlSticked)
							.frame(width: bounds.width, height: 70)
					}
				}
				.offset(y: ls.pageTabControlSize.height)
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
				ZStack {
					Divider()
						.opacity(aggregatedLayoutDividerOpacity)
						.offset(y: walletDashboardViewState.tokenLayout != .aggregated ? ls.conditions.navbarTitleYOffset : 0)
					Divider()
						.opacity(nonAggregatedLayoutDividerOpacity)
				}
				.animation(.easeInOut, value: ls.conditions.navBarVisibility)
			}
		}
	}
	
	private var aggregatedLayoutDividerOpacity: CGFloat {
		if walletDashboardViewState.tokenLayout == .aggregated && ls.conditions.navBarVisibility {
			return 0.8
		} else if ls.conditions.navBarVisibility {
			return 0.8 * ls.conditions.navbarOpacity
		} else {
			return 0.0
		}
	}
	
	private var nonAggregatedLayoutDividerOpacity: CGFloat {
		if walletDashboardViewState.tokenLayout == .aggregated {
			return 0
		} else if ls.conditions.pageNavbarContact {
			return 0.8
		} else {
			return 0
		}
	}
	
	@ViewBuilder
	private var navBarButtons: some View {
		HStack {
			Spacer()
			Button(action: { }) {
				Image("icon_qrscanner")
					.resizable()
					.frame(width: 22, height: 22)
					.opacity(walletDashboardViewState.tokenLayout != .aggregated ? ls.conditions.navbarOpacity : 1.0)
			}
			.padding(.trailing, 21)
		}
		.offset(y: walletDashboardViewState.tokenLayout != .aggregated ? ls.conditions.navbarTitleYOffset : .zero)
//		.offset(y: navbarDisappearingCondition ? -100 : 0)
//		.animation(.navbarAnimation(navbarDisappearingCondition), value: navbarDisappearingCondition)
	}
	
	@ViewBuilder
	private func WalletDashboardTitle() -> some View {
		Text("Wallet")
			.font(.montserrat(.title2))
			.fontWeight(.bold)
			.opacity(walletDashboardViewState.tokenLayout != .aggregated ? ls.conditions.navbarOpacity : 1.0)
			.extendingContent(.horizontal)
		     // due to a bug in swiftui,
		     // without explicit frame text breaks
		     // y-origin of a scroll view inner coordinate space
			.frame(height: ls.navbarHeight)
//			.offset(y: navbarDisappearingCondition ? -100 : 0)
//			.animation(.navbarAnimation(ls.conditions.pageTabControlSticked), value: ls.conditions.pageTabControlSticked)
	}
	
	private var navbarDisappearingCondition: Bool {
		if walletDashboardViewState.tokenLayout != .aggregated {
			return ls.conditions.pageTabControlSticked
		}
		return false
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

extension Animation {
	static func navbarAnimation(_ condition: Bool) -> Animation {
			.easeOut(duration: .dashboardNavbarAnimationDuration).delay(condition ? .dashboardNavbarAnimationDelay : 0)
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


