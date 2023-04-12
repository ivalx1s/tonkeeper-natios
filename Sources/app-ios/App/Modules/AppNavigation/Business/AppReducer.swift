extension NavigationState {
    var reducer: Reducer<NavigationState, NavigationAction> {
        Reducer { state, action in
            switch action {
            case let .setRootPage(page):
                Task {
                    state.rootPage = page
                }
            case let .setMainPage(page):
                Task {
                    state.mainPage = page
                }
            case let .setModalPage(page):
                Task {
                    state.modalPage = page
                }
            case let .setModalSheet(page):
                Task {
                    state.modalSheet = page
                }
            case let .setAlert(type):
                Task {
                    state.alert = type
                }
            }
        }
    }
}

