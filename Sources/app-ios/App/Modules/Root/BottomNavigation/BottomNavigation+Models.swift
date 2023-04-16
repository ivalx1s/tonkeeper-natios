import Foundation

extension BottomNavigation {
    struct Props {
        let activeItemId: String?
        let items: [Item]
    }
}

extension BottomNavigation {
    struct Item: Identifiable {
        let id: String
        let label: String
        let icon: String
		let icon_secondary: String?
        let iconScaleFactor: CGFloat
        let onSelect: () async -> ()
    }
}
