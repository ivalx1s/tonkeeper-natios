enum AppModalPage {
	case changelog
}

extension AppModalPage: Identifiable {
	var id: String {
		switch self {
			case .changelog:
				return "changelog"
		}
	}
}
