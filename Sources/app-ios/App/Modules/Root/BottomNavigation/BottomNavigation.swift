import TonkUI
import Combine

extension BottomNavigation {
    enum BgType {
    case clear
    case systemMaterial
    }
}

extension BottomNavigation {
    class LocalState: ObservableObject {
        @Published var bgType: BgType = .clear
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
                .onAppear { bindScreenSize() }
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
								Image(item.icon)
									.resizable()
									.frame(width: 18, height: 18)
                                    .scaleEffect(item.iconScaleFactor * (isSelected ? 1.1 : 1))
									.grayscale(isSelected ? 0 : 1)
									.padding(.bottom, 8)
									.dropShadow(type: .sameView(opacity: isSelected ? 1 : 0), radius: 4)
                                    .animation(.easeInOut(duration: 0.15), value: isSelected)
                                Text(item.label)
									.font(.montserrat(.caption2))
									.fontWeight(.semibold)
									.scaleEffect(0.83)
									.foregroundColor(isSelected ? .primary : .secondary)
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
        SystemMaterial(.systemUltraThinMaterial)
                .opacity(ls.bgType == .clear ? 0 : 1)
                .animation(.easeInOut(duration: 0.1), value: ls.bgType)
    }

    private func checkAppearance(_ rect: CGRect) {
        ls.contentFrame = rect
    }

    private func bindScreenSize() {
        ls.screenBounds = bounds
        ls.safeAreaInsets = safeAreaEdgeInsets
    }
}
