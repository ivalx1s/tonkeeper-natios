import Combine

extension WalletDashboardView {
	class LocalState: ObservableObject {
		let contentNameSpace = "walletDashboard"
		
		@Published var navBarBgOpacity: CGFloat = 0
		@Published var contentRect: CGRect = .zero
		
		
		@Published private(set) var navbarTitleYOffset: CGSize = .zero
		@Published private(set) var pageTabControlYOffset: CGSize = .zero
		@Published private(set) var pageViewOffset: CGFloat = 0
		
		
		@Published var pageTabControlSticked: Bool = false
		@Published var pageTabControl: CGRect = .zero
		
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
			
			$pageTabControl
				.map { rect in
					let yOrigin = rect.origin.y
//					print("yOrigin: \(yOrigin); \(yOrigin <= 0)")
					return yOrigin <= 0
				}
				.assign(to: &$pageTabControlSticked)
			
			$pageTabControl
				.map { rect in
					let yOrigin = rect.origin.y
					if yOrigin < 0 {
						return .init(width: 0, height: yOrigin)
					} else {
						return .zero
					}
				}
				.assign(to: &$navbarTitleYOffset)
			
			$pageTabControl
				.map { rect in
					let yOrigin = rect.origin.y
					if yOrigin < 0 {
						let max = max(yOrigin, -50)
						print("max: \(max)")
						return .init(width: 0, height: max)
					} else {
						return .zero
					}
				}
				.assign(to: &$pageTabControlYOffset)
			

		}
	}
}
