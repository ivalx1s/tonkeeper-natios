import FoundationPlus

extension SettingsState {
	var reducer: Reducer<SettingsState, SettingsAction> {
		Reducer { state, action in
			exec {
				switch action {
					case let .obtainSettingsSuccess(settings):
						state.settings = settings
				}
			}
		}
	}
}
