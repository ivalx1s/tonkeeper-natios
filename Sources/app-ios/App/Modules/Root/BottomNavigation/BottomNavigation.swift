import TonkUI
import Combine

extension BottomNavigation {
	enum BgType: Equatable {
		case clear
		case color(Color)
		case systemMaterial
	}
}

extension BottomNavigation {
    class LocalState: ObservableObject {
		private var pipelines: Set<AnyCancellable> = []
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
						
						return -1 * content.origin.y
                                + screenBounds.height
                                - tabbar.height
                                - screenInsets.top - screenInsets.bottom
                        < content.height
                                ? .systemMaterial
                                : .clear
                    }
                    .assign(to: &$bgType)
			
			$bgType
				.sink { _ in
					print("")
				}
				.store(in: &pipelines)
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
//				.border(.red, width: 1/3)
    }

	private var content: some View {
		HStack(alignment: .bottom, spacing: 0) {
			ForEach(props.items) { item in
				let isSelected = item.id == props.activeItemId
				HStack(spacing: 0) {
					Spacer()
					AsyncButton(action: item.onSelect) {
						TabItemView(item, isSelected: isSelected)
					}
					.buttonStyle(TabViewItemButtonStyle())
					Spacer(minLength: 0)
				}
			}
		}
		.extendingContent(.horizontal)
		.frame(height: .navbarHeight)
	}
	
	@ViewBuilder
	private func TabItemView(_ item: Item, isSelected: Bool) -> some View {
		VStack(spacing: 0) {
			Spacer()
			Image(item.icon)
				.resizable()
				.frame(width: 23, height: 23)
				.foregroundColor(isSelected ? Color.tonBlue : Color.tonSecondaryLabel)
				.grayscale(isSelected ? 0 : 1)
				.padding(.bottom, 4)
				.scaleEffect(1.2)
				.animation(.easeInOut(duration: 0.15), value: isSelected)
			Text(LocalizedStringKey(item.label))
				.font(.montserrat(.footnote))
				.foregroundColor(isSelected ? Color.tonBlue : .tonSecondaryLabel)
		}
		.contentShape(Rectangle())
//		.border(.green, width: 1/3)
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

extension CGFloat {
	static var navbarHeight: CGFloat {
		50
	}
}
