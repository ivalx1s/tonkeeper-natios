import KeychainAccess

protocol ISettingsService {
    func getSettings() -> Settings
    func resetAppSettings()
}

fileprivate extension UserDefaults {
    enum Key: String {
        case appSettingsKey = "TonkeeperNatiosSettings"
    }
}

class SettingsService: ISettingsService {
	
    init() {
    }

    func getSettings() -> Settings {
        .init(
                appSettings: getAppSettings()
        )
    }
	
    func resetAppSettings() {
        UserDefaults.standard.removeObject(forKey: UserDefaults.Key.appSettingsKey.rawValue)
    }

    private func getAppSettings() -> AppSettings {
		let settings = AppSettings(fromJsonData: UserDefaults.standard.data(forKey: UserDefaults.Key.appSettingsKey.rawValue))
                ?? .init()
        return settings
    }

    private func upsertAppSettings(_ settings: AppSettings) {
        UserDefaults.standard.set(settings.asJsonData, forKey: UserDefaults.Key.appSettingsKey.rawValue)
    }
	
}




