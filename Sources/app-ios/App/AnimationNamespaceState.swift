import TonkUI


// adapt to perdux
final class AnimationNamespaceState: PerduxViewState {
	@Published var namespaces: Dictionary<Namespace.Scope, Namespace.ID> = [:]
}


extension Namespace {
	enum Scope: String {
		case root = "rootNamespace"
	}
	
	enum Id: String {
		case walletControlButtons = "walletControlButtons"
	}
}



