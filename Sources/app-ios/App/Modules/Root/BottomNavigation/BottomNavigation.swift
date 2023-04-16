import TonkUI
import Combine

extension BottomNavigation {
	enum BgType {
		case clear
		case color(Color)
		case systemMaterial
	}
}

extension BottomNavigation {
    class LocalState: ObservableObject {
		@Published var bgType: BgType = .color(.tonSystemBackground)
        @Published var tabbarFrame: CGRect = .zero
        @Published var contentFrame: CGRect = .zero
        @Published var screenBounds: CGRect = .zero
        @Published var safeAreaInsets: EdgeInsets = .init()

        init() {
            initPipelines()
        }

        private func initPipelines() {
            Publishers
                    .CombineLatest4($contentFrame, $tabbarFrame, $screenBounds, $safeAreaInsets)
                    .map { content, tabbar, screenBounds, screenInsets in

//                        print("content: \(content)")
//                        print("tabbar: \(tabbar)")
//                        print("screenBounds: \(screenBounds)")
//                        print("insets: \(screenInsets)")
                        -1 * content.origin.y
                                + screenBounds.height
                                - tabbar.height
                                - screenInsets.top - screenInsets.bottom
                        < content.height
                                ? .systemMaterial
                                : .clear
                    }
                    .assign(to: &$bgType)
        }
    }
}

struct BottomNavigation: View {
    let props: Props
    @Environment(\.bounds) private var bounds
    @Environment(\.safeAreaEdgeInsets) private var safeAreaEdgeInsets
    @Environment(\.contentFrame) private var contentFrame
    @StateObject private var ls: LocalState = .init()

    var body: some View {
        content
                .storingSize(in: $ls.tabbarFrame)
                .background(bg.ignoresSafeArea(edges: .bottom))
                .onChange(of: contentFrame, perform: checkAppearance)
                .onAppear {
					bindScreenSize()
				}
    }

    private var content: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(props.items) { item in
                    let isSelected = item.id == props.activeItemId
                    AsyncButton(action: item.onSelect) {
						HStack(spacing: 0) {
							Spacer()
							VStack(spacing: 0) {
								ZStack {
									Image(item.icon)
										.resizable()
									if let icon_secondary = item.icon_secondary {
										Image(icon_secondary)
									}
								}
									.frame(width: 23, height: 23)
									.grayscale(isSelected ? 0 : 1)
									.foregroundColor(isSelected ? Color.tonBlue : Color.tonSecondaryLabel)
									.padding(.bottom, 8)
                                    .animation(.easeInOut(duration: 0.15), value: isSelected)
                                Text(LocalizedStringKey(item.label))
									.font(.montserrat(.footnote))
									.foregroundColor(isSelected ? Color.tonBlue : .tonSecondaryLabel)
							}
							Spacer()
						}
						.contentShape(Rectangle())
                    }
					.buttonStyle(TabViewItemButtonStyle())

                }
                Spacer(minLength: 1)
            }.padding(.top, 8)
        }
    }

    @ViewBuilder
    private var bg: some View {
		VStack(spacing: 0) {
//			Divider()
			Color.tonSystemBackground
		}
    }

    private func checkAppearance(_ rect: CGRect) {
        ls.contentFrame = rect
    }

    private func bindScreenSize() {
        ls.screenBounds = bounds
        ls.safeAreaInsets = safeAreaEdgeInsets
    }
}
