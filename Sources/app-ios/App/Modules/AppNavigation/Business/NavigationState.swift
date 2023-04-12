import Combine

final class NavigationState: PerduxState, ObservableObject {
	@Published var rootPage: AppRootPage?
	@Published var mainPage: MainPage?
    @Published var modalPage: AppModalPage?
    @Published var modalSheet: AppModalPage?
    @Published var alert: AlertType?

    func reduce(with action: PerduxAction) async {
        guard let action = action as? NavigationAction else {
            return
        }

        await reducer.reduce(self, action)
    }


    func cleanup() async {
    }
}
