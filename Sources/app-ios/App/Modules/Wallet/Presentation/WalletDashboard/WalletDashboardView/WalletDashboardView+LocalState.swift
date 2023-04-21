import Combine
import Foundation

extension WalletDashboardView {
	struct Conditions: Equatable {
		let navBarVisibility: Bool
		let pageTabControlSticked: Bool
		let pageTabControlYOffset: CGFloat
		let navbarTitleYOffset: CGFloat
		let navbarOpacity: CGFloat
		
		static var `default`: Self = .init(
			navBarVisibility: true,
			pageTabControlSticked: false,
			pageTabControlYOffset: .zero,
			navbarTitleYOffset: .zero,
			navbarOpacity: 1
		)
	}
	
	class LocalState: ObservableObject {
		var pipelines: Set<AnyCancellable> = []
		let contentNameSpace = "walletDashboard"
		let queue = DispatchQueue(label: "viewFrameReaderQueue", qos: .userInteractive)
	
		
		let rectSubject = PassthroughSubject<CGRect, Never>()
		var rectPublisher: AnyPublisher<CGRect, Never> {
			rectSubject.eraseToAnyPublisher()
		}
		
		@Published private(set) var conditions: Conditions = .default
		private(set) var navbarHeight: CGFloat = 64
		
		@Published var pageTabControlSize: CGSize = .zero
		static var pageTabControlInitialYOrigin: CGFloat = .zero
		
		
		init() {
			bindFields()
		}
	
		
		private func bindFields() {
			rectPublisher
				.subscribe(on: queue)
				.receive(on: queue)
				.map {
					let yOrigin = $0.origin.y
					return yOrigin
				}
				.map { Self.roundToPrecision($0, precision: 2) }
				.removeDuplicates()
				.map {
					Conditions(
						navBarVisibility: Self.checkNavBarBgVisibilityCondition($0),
						pageTabControlSticked: Self.checkPageTabControlStickedCondition($0),
						pageTabControlYOffset: Self.checkPageTabControlYOffset($0),
						navbarTitleYOffset: Self.checkNavbarTitleYOffsetCondition($0),
						navbarOpacity: Self.checkNavbarOpacityCondition($0)
					)
				}
				.removeDuplicates()
				.throttle(for: 0.016, scheduler: DispatchQueue.main, latest: false)
				.receive(on: DispatchQueue.main)
				.sink { [weak self] (conditions: Conditions) in
					self?.conditions = conditions
				}
				.store(in: &pipelines)
		}
		
		private static func checkNavbarOpacityCondition(_ yOrigin: CGFloat) -> CGFloat {
			switch yOrigin {
				case ...(-Self.pageTabControlInitialYOrigin):
					return calculateOpacity(initialYOrigin: Self.pageTabControlInitialYOrigin, currentYOrigin: yOrigin)
				default:
					return 1
			}
		}
		
		private static func checkNavBarBgVisibilityCondition(_ yOrigin: CGFloat) -> Bool {
			switch yOrigin {
				case ..<0: return true
				case 0...: return false
				default: return false
			}
		}
		
		
		private static func checkPageTabControlYOffset(_ yOrigin: CGFloat) -> CGFloat {
			if yOrigin < (-1*Self.pageTabControlInitialYOrigin) {
				let offset = yOrigin + Self.pageTabControlInitialYOrigin
				return max(offset, .dashboardNavbarPageControlStickedOffset)
			} else {
				return .zero
			}
		}
		
		private static func checkPageTabControlStickedCondition(_ yOrigin: CGFloat) -> Bool {
			guard yOrigin < 0 else { return false }
			let shouldBeSticked = yOrigin <= (-1*Self.pageTabControlInitialYOrigin)
			return shouldBeSticked
		}
		
		private static func checkNavbarTitleYOffsetCondition(_ yOrigin: CGFloat) -> CGFloat {
			if yOrigin < (-1*Self.pageTabControlInitialYOrigin) {
				let offset = yOrigin + Self.pageTabControlInitialYOrigin
				
				return max(offset, -200)
			} else {
				return .zero
			}
		}
		
		
		static private func roundToPrecision(_ value: CGFloat, precision: Int) -> CGFloat {
			let multiplier = pow(10, CGFloat(precision))
			return round(value * multiplier) / multiplier
		}
		
		static private func calculateOpacity(initialYOrigin: CGFloat, currentYOrigin: CGFloat) -> CGFloat {
			let yDiff = -initialYOrigin - currentYOrigin
			let opacityChangePerPoint = 1.0 / 60.0
			let opacity = max(1 - (yDiff * opacityChangePerPoint), 0)
			return opacity
		}
	}
	
}
