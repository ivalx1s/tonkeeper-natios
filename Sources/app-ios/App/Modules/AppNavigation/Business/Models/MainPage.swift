enum MainPage: Equatable, Identifiable {
	case undefined
	case wallet(subpage: Wallet)
	case activity
	case browser
	case settings(subpage: Settings)
	
	
	var id: String {
		switch self {
			case let .settings(subpage):
				return "settings-\(subpage.rawValue)"
			case let .wallet(subpage):
				return "wallet-\(subpage.rawValue)"
			case .undefined:
				return "undefined"
			case .activity:
				return "activity"
			case .browser:
				return "browser"
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
			case .activity:
				return "Activity"
			case .browser:
				return "Browser"
		}
	}
	
	var icon: String {
		switch self {
			case .wallet:
				return "icon_wallet_foreground"
			case .settings:
				return "icon_settings"
			case .undefined:
				return "undefined"
			case .activity:
				return "icon_activity_foreground"
			case .browser:
				return "icon_browser"
		}
	}
	
	var icon_secondary: String? {
		switch self {
			case .wallet:
				return "icon_wallet_background"
			case .settings:
				return nil
			case .undefined:
				return nil
			case .activity:
				return "icon_activity_background"
			case .browser:
				return nil
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
			case .activity:
				return 1
			case .browser:
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
