protocol ISettingsSaga: PerduxSaga {
	
}

final class SettingsSaga: ISettingsSaga {
    private let settingsSvc: ISettingsService

    init(
            settingsSvc: ISettingsService
    ) {
        self.settingsSvc = settingsSvc
    }

    func apply(_ effect: PerduxEffect) async {
        switch effect as? SettingsSideEffect {
        case .none: break
        case let .some(val):
            switch val {
            case .obtainSettings:
                await obtainSettings()
            case .resetSettings:
                await resetSettings()
            }
        }
    }
	

	private func obtainSettings() async {
		let settings = settingsSvc.getSettings()
		await action {
			SettingsAction.obtainSettingsSuccess(settings: settings)
		}
	}

    private func resetSettings() async {
        settingsSvc.resetAppSettings()
        let settings = settingsSvc.getSettings()
		await action {
			SettingsAction.obtainSettingsSuccess(settings: settings)
		}
    }
}
