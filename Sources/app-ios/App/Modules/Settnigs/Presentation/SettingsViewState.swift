@MainActor
class SettingsViewState: PerduxViewState {

	
	init(settingsState: SettingsState) {
		Task {
			await initPipelines(settingsState: settingsState)
		}
	}
	
	private func initPipelines(settingsState: SettingsState) async {
		
	}
}
