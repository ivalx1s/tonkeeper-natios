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
	@Published private(set) var bottomNavShown: Bool = true
	
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
	}
}
