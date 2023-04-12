import Combine
import SandboxPermissions
import TonkUI


final class SettingsState: PerduxState, ObservableObject {
    private var pipelines: Set<AnyCancellable> = []
    let sandboxPermissions: SandboxPermissionsManager

    @Published var settings: Settings? = nil
	
    init(
        sandboxPermissions: SandboxPermissionsManager
    ) {
        self.sandboxPermissions = sandboxPermissions
        initPipelines()
    }
    
    private func initPipelines() {

    }
    
    func reduce(with action: PerduxAction) async {
        guard let action = action as? SettingsAction else {
            return
        }

        await reducer.reduce(self, action)
    }

    func cleanup() async {
        debug("cleanup is not implemented")
    }
}


