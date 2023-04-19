import TonkUI

extension WalletDashboardView {
	struct PageTabControl: View {
		
		@Binding private var activePageIdx: Int?
		//		@Binding private var activeTabIdx: Int?
		
		private let tokenLayout: WalletDashboardView.TokenLayout
		private let longestTabSelectorTextWidth: CGFloat?
		private let pageTabSelectorOffset: CGFloat
		
		
		init(
			_ tokenLayout: WalletDashboardView.TokenLayout,
			activePageIdx: Binding<Int?>,
			longestTabSelectorTextWidth: CGFloat?,
			pageTabSelectorOffset: CGFloat
			
		) {
			self.tokenLayout = tokenLayout
			self._activePageIdx = activePageIdx
			//			self._activeTabIdx = activeTabIdx
			self.longestTabSelectorTextWidth = longestTabSelectorTextWidth
			self.pageTabSelectorOffset = pageTabSelectorOffset
		}
		
		
		var body: some View {
			HPageView(alignment: .leading, pageWidth: longestTabSelectorTextWidth, spacing: 8, activePageIndex: $activePageIdx) {
				ForEach(tokenLayout.asPages.numbered(startingAt: 0)) { aggregatedType in
					VStack(spacing: 0) {
						switch aggregatedType.element {
							case let .fungibleAggregation(walletAssetTypes):
								if walletAssetTypes.aggregatedFungibleAndNonLiquid {
									SelectorButton(activePageIdx: $activePageIdx, walletAssetTypes: walletAssetTypes, indexToSet: aggregatedType.number)
										.overlay(
											GeometryReader { proxy in
												Color.clear.preference(key: TabSizeKey.self, value: [proxy.size])
											}
										)
								} else {
									SelectorButton(activePageIdx: $activePageIdx, walletAssetTypes: walletAssetTypes, indexToSet: aggregatedType.number)
										.overlay(
											GeometryReader { proxy in
												Color.clear.preference(key: TabSizeKey.self, value: [proxy.size])
											}
										)
								}
								
							case let .nonFungibleAggregation(walletAssetTypes):
								ForEach(walletAssetTypes) { assetType in
									SelectorButton(activePageIdx: $activePageIdx, walletAssetTypes: walletAssetTypes, indexToSet: aggregatedType.number)
										.overlay(
											GeometryReader { proxy in
												Color.clear.preference(key: TabSizeKey.self, value: [proxy.size])
											}
										)
								}
						}
					}
				}
			}
			//			.onAppear {
			//				self.pageTabControlProxy = proxy
			//			}
			.extendingContent(.horizontal)
			.padding(.vertical)
			.frame(height: 70)
			//local.offset(x: pageTabSelectorOffset)
			.padding(.vertical)
//			.safeAreaInset(edge: .leading) {
//				Color.clear
//					.frame(
//						width: tokenLayout.asPages.count > 2
//						? 16
//						: 0,
//						height: 0
//					)
//			}
		}
		
		@ViewBuilder
		private func SelectorButton(activePageIdx: Binding<Int?>, walletAssetTypes: [WalletAssetType], indexToSet: Int) -> some View {
			VStack(alignment: .center, spacing: 11) {
				Button(action: {
					activePageIdx.wrappedValue = indexToSet
				}) {
					Text(LocalizedStringKey(walletAssetTypes[0].rawValue))
					PageSelectionIndicator()
						.opacity(activePageIdx.wrappedValue == indexToSet ? 1 : 0)
						.animation(.easeInOut(duration: 0.3), value: activePageIdx.wrappedValue == indexToSet)
				}
				.buttonStyle(.pageSelector(isSelected: activePageIdx.wrappedValue == indexToSet))
			}
		}
		
	}
}

extension WalletDashboardView.PageTabControl {
	@ViewBuilder
	private func PageSelectionIndicator() -> some View {
		RoundedRectangle(cornerRadius: 3, style: .continuous)
			.frame(width: 24, height: 3)
			.foregroundColor(.tonBlue)
	}
}
