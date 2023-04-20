import TonkUI

extension WalletDashboardView {
	struct PageTabControl: View {
		
		@Namespace private var pageTabControl
		@Environment(\.bounds) private var bounds
		
		@Binding private var activePageIdx: Int?
		@Binding private var totalTabsWidth: CGFloat?
		
		//		@Binding private var activeTabIdx: Int?
		
		private let tokenLayout: WalletDashboardView.TokenLayout
		private let longestTabSelectorTextWidth: CGFloat?
		private let pageTabSelectorOffset: CGFloat
		
		
		init(
			_ tokenLayout: WalletDashboardView.TokenLayout,
			activePageIdx: Binding<Int?>,
			longestTabSelectorTextWidth: CGFloat?,
			totalTabsWidth: Binding<CGFloat?>,
			pageTabSelectorOffset: CGFloat
			
		) {
			self.tokenLayout = tokenLayout
			self._activePageIdx = activePageIdx
			self._totalTabsWidth = totalTabsWidth
			self.longestTabSelectorTextWidth = longestTabSelectorTextWidth
			self.pageTabSelectorOffset = pageTabSelectorOffset
		}
		
		var body: some View {
			VStack(spacing: 0) {
				if totalTabsWidth ?? 0 < bounds.width {
					StaticSelector(activePageIdx: $activePageIdx, assetPages: tokenLayout.asPages.numbered(startingAt: 0), animationNamespace: pageTabControl)
						.onAppear {
//							print("totalTabsWidth < bounds.width \(totalTabsWidth ?? 0 < bounds.width); \(totalTabsWidth) \(bounds.width)")
						}
				} else {
					ScrollableSelector(activePageIdx: $activePageIdx, longestTabSelectorTextWidth: longestTabSelectorTextWidth, assetPages: tokenLayout.asPages.numbered(startingAt: 0), animationNamespace: pageTabControl)
						.onAppear {
//							print("")
						}
						.safeAreaInset(edge: .leading, spacing: 0) {
							Color.clear.frame(width: 16, height: 0)
						}
						
				}
			}
			.extendingContent(.horizontal)
			.padding(.top)
			.frame(width: bounds.width, height: 70)
		}
	}
}

extension WalletDashboardView {
	struct SelectorButton: View {
		
		@Binding var activePageIdx: Int?
		let walletAssetTypes: [WalletAssetType]
		let indexToSet: Int
		let animationNamespace: Namespace.ID
		
		var body: some View {
			_SelectorButton(activePageIdx: $activePageIdx, walletAssetTypes: walletAssetTypes, indexToSet: indexToSet)
		}
		
		@ViewBuilder
		private func _SelectorButton(activePageIdx: Binding<Int?>, walletAssetTypes: [WalletAssetType], indexToSet: Int) -> some View {
			VStack(alignment: .center, spacing: 11) {
				Button(action: {
					activePageIdx.wrappedValue = indexToSet
				}) {
					Text(LocalizedStringKey(walletAssetTypes[0].rawValue))
					if activePageIdx.wrappedValue == indexToSet {
						PageSelectionIndicator()
							.matchedGeometryEffect(id: "PageSelectionIndicator", in: animationNamespace)
					} else {
						// layout reservation
						PageSelectionIndicator()
							.opacity(0)
					}
						
				}
				.buttonStyle(.pageSelector(isSelected: activePageIdx.wrappedValue == indexToSet))
				.animation(.easeOut(duration: 0.2), value: activePageIdx.wrappedValue == indexToSet)
			}
		}
		
		@ViewBuilder
		private func PageSelectionIndicator() -> some View {
			RoundedRectangle(cornerRadius: 3, style: .continuous)
				.frame(width: 24, height: 3)
				.foregroundColor(.tonBlue)
		}
		
	}
}


extension WalletDashboardView {

	
	struct StaticSelector: View {
		@Binding var activePageIdx: Int?
		let assetPages: [Numbered<WalletDashboardView.AssetPage>]
		let animationNamespace: Namespace.ID
	
		var body: some View {
			HStack(spacing: 0) {
				ForEach(assetPages) { aggregatedType in
					switch aggregatedType.element {
						case let .page(walletAssetTypes):
							if walletAssetTypes.isFungibleOrNonLiquid {
								SelectorButton(activePageIdx: $activePageIdx, walletAssetTypes: walletAssetTypes, indexToSet: aggregatedType.number, animationNamespace: animationNamespace)
									.padding(.horizontal, 16)
									.matchedGeometryEffect(id: "FungibleOrNonLiquid", in: animationNamespace)
//									.border(.red)
									.overlay(
										GeometryReader { proxy in
											Color.clear.preference(key: TabSizeKey.self, value: [proxy.size])
												.onAppear {
//													print("proxy.size.width: \(proxy.size.width)")
												}
										}
									)
							} else {
								SelectorButton(activePageIdx: $activePageIdx, walletAssetTypes: walletAssetTypes, indexToSet: aggregatedType.number, animationNamespace: animationNamespace)
									.padding(.horizontal, 16)
									.matchedGeometryEffect(id: aggregatedType.number, in: animationNamespace)
//									.border(.red)
									.overlay(
										GeometryReader { proxy in
											Color.clear.preference(key: TabSizeKey.self, value: [proxy.size])
												.onAppear {
//													print("proxy.size.width: \(proxy.size.width)")
												}
										}
									)
							}
					}
				}
			}
		}
		
	}
	
	struct ScrollableSelector: View {
		@Environment(\.bounds) private var bounds
		@Binding var activePageIdx: Int?
		let longestTabSelectorTextWidth: CGFloat?
		let assetPages: [Numbered<WalletDashboardView.AssetPage>]
		let animationNamespace: Namespace.ID
		
		var body: some View {
			
			HPageView(alignment: .leading, pageWidth: longestTabSelectorTextWidth, spacing: 0, activePageIndex: $activePageIdx) {
				ForEach(assetPages) { aggregatedType in
					VStack(spacing: 0) {
						switch aggregatedType.element {
							case let .page(walletAssetTypes):
								if walletAssetTypes.isFungibleOrNonLiquid {
									SelectorButton(activePageIdx: $activePageIdx, walletAssetTypes: walletAssetTypes, indexToSet: aggregatedType.number, animationNamespace: animationNamespace)
										.matchedGeometryEffect(id: "FungibleOrNonLiquid", in: animationNamespace)
//										.border(.red)
										.overlay(
											GeometryReader { proxy in
												Color.clear.preference(key: TabSizeKey.self, value: [proxy.size])
													.onAppear {
														print("proxy.size.width: \(proxy.size.width)")
													}
											}
										)
								} else {
									SelectorButton(activePageIdx: $activePageIdx, walletAssetTypes: walletAssetTypes, indexToSet: aggregatedType.number, animationNamespace: animationNamespace)
										.matchedGeometryEffect(id: aggregatedType.number, in: animationNamespace)
//										.border(.red)
										.overlay(
											GeometryReader { proxy in
												Color.clear.preference(key: TabSizeKey.self, value: [proxy.size])
													.onAppear {
														print("proxy.size.width: \(proxy.size.width)")
													}
											}
										)
								}
						}
					}
				}
			}
		}
		
		private func tabSelectorOffset(whenPageIdx pageIdx: Int?) -> CGFloat {
			CGFloat(pageIdx ?? 0) * (longestTabSelectorTextWidth ?? 0)
		}
	}
	
}

extension WalletDashboardView.PageTabControl {
	
}
