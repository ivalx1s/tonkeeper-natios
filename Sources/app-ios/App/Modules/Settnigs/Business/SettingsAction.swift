enum SettingsAction: PerduxAction {
    var qos: DispatchQoS { .default }

    case obtainSettingsSuccess(settings: Settings)
}
