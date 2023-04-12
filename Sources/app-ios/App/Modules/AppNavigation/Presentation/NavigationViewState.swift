import Combine
import TonkUI

@MainActor
final class NavigationViewState: PerduxViewState {
	private var pipelines: Set<AnyCancellable> = []
	
	@Published private(set) var rootPage: AppRootPage?
	@Published private(set) var mainPage: MainPage?
	@Published var modalPage: AppModalPage?
	@Published var modalSheet: AppModalPage?
	@Published var alert: AlertType?
	@Published private(set) var bottomNavShown: Bool = false
	
	init(navState: NavigationState) {
		initPipelines(navState: navState)
	}
	
	private func initPipelines(navState: NavigationState) {
		navState.$rootPage
			.subscribe(on: DispatchQueue.main)
			.receive(on: DispatchQueue.main)
			.assign(to: &$rootPage)
		
		navState.$mainPage
			.subscribe(on: DispatchQueue.main)
			.receive(on: DispatchQueue.main)
			.assign(to: &$mainPage)
		
		navState.$modalPage
			.subscribe(on: DispatchQueue.main)
			.receive(on: DispatchQueue.main)
			.assign(to: &$modalPage)
		
		navState.$modalSheet
			.subscribe(on: DispatchQueue.main)
			.receive(on: DispatchQueue.main)
			.assign(to: &$modalSheet)
		
		navState.$alert
			.subscribe(on: DispatchQueue.main)
			.receive(on: DispatchQueue.main)
			.assign(to: &$alert)
		
		$mainPage
			.subscribe(on: DispatchQueue.main)
			.map { mainPage in
				guard let mainPage else {
					return true
				}
				switch mainPage {
					case let .wallet(subpage):
						switch subpage {
							case .dashboard:
								return true
							case .scanner:
								return false
						}
					case .settings:
						return true
						
					case .undefined:
						return true
				}
			}
			.receive(on: DispatchQueue.main)
			.assign(to: &$bottomNavShown)
	}
}
