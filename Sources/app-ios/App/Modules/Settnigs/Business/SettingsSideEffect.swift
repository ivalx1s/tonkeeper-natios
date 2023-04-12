enum SettingsSideEffect: PerduxEffect, EnumReflectable {
    var qos: DispatchQoS {.userInteractive }

    case obtainSettings
    case resetSettings
}
