import Combine
import Foundation

extension WalletDashboardView {
	struct Conditions: Equatable {
		let navBarVisibility: Bool
		let pageTabControlSticked: Bool
		let pageTabControlYOffset: CGFloat
		let navbarTitleYOffset: CGFloat
		
		static var `default`: Self = .init(
			navBarVisibility: true,
			pageTabControlSticked: false,
			pageTabControlYOffset: .zero,
			navbarTitleYOffset: .zero
		)
	}
	
	class LocalState: ObservableObject {
		var pipelines: Set<AnyCancellable> = []
		let contentNameSpace = "walletDashboard"
		let queue = DispatchQueue(label: "viewFrameReaderQueue", qos: .default)
	
		
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
				.map { Self.roundToPrecision($0, precision: 1) }
				.map {
					Conditions(
						navBarVisibility: Self.checkNavBarBgVisibilityCondition($0),
						pageTabControlSticked: Self.checkPageTabControlStickedCondition($0),
						pageTabControlYOffset: Self.checkPageTabControlYOffset($0),
						navbarTitleYOffset: Self.checkNavbarTitleYOffsetCondition($0)
					)
				}
				.removeDuplicates()
				.receive(on: DispatchQueue.main)
				.sink { [weak self] (conditions: Conditions) in
					self?.conditions = conditions
//					self?.navBarBgVisible = conditions.navBarVisibility
//					self?.pageTabControlSticked = conditions.pageTabControlSticked
//					self?.pageTabControlYOffset = conditions.pageTabControlYOffset
//					self?.navbarTitleYOffset = conditions.navbarTitleYOffset
				}
				.store(in: &pipelines)
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
				return max(offset, -70)
			} else {
				return .zero
			}
		}
		
		private static func checkPageTabControlStickedCondition(_ yOrigin: CGFloat) -> Bool {
			return yOrigin <= (-1*Self.pageTabControlInitialYOrigin)
		}
		
		private static func checkNavbarTitleYOffsetCondition(_ yOrigin: CGFloat) -> CGFloat {
			if yOrigin < (-1*Self.pageTabControlInitialYOrigin) {
				let offset = yOrigin + Self.pageTabControlInitialYOrigin
				
				return max(offset, -100)
			} else {
				return .zero
			}
		}
		
		
		static private func roundToPrecision(_ value: CGFloat, precision: Int) -> CGFloat {
			let multiplier = pow(10, CGFloat(precision))
			return round(value * multiplier) / multiplier
		}
	}
	
}
