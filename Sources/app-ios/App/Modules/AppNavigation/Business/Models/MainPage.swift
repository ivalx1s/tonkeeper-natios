enum MainPage: Equatable, Identifiable {
	case undefined
	case wallet(subpage: Wallet)
	case settings(subpage: Settings)
	
	
	var id: String {
		switch self {
			case let .settings(subpage):
				return "settings-\(subpage.rawValue)"
			case let .wallet(subpage):
				return "wallet-\(subpage.rawValue)"
			case .undefined:
				return "undefined"
		}
	}
	
	var label: String {
		switch self {
			case .settings:
				return "Settings"
			case .wallet:
				return "Wallet"
			case .undefined:
				return "undefined"
		}
	}
	
	var icon: String {
		switch self {
			case .wallet:
				return "icon_wallet"
			case .settings:
				return "icon_settings"
			case .undefined:
				return "undefined"
		}
	}
	
	var iconScaleFactor: CGFloat {
		switch self {
			case .settings:
				return 1
			case .wallet:
				return 1
			case .undefined:
				return 1
		}
	}
	
	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.id == rhs.id
	}
}


extension MainPage {
	enum Wallet: String {
		case dashboard
		case scanner
	}
	
	enum Settings: String {
		case general
		case debugMenu
	}
}
