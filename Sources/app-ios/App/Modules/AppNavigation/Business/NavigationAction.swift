enum NavigationAction: PerduxAction, EnumReflectable {
    var qos: DispatchQoS { .userInteractive }

    case setRootPage(AppRootPage)
    case setModalPage(AppModalPage?)
    case setModalSheet(AppModalPage?)
    case setMainPage(MainPage)
    case setAlert(AlertType)
}
