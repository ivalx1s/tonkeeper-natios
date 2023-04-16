import Foundation

extension BottomNavigation {
	static func buildItem(for page: MainPage) -> Item {
		.init(
			id: page.id,
			label: page.label,
			icon: page.icon,
			icon_secondary: page.icon_secondary,
			iconScaleFactor: page.iconScaleFactor,
			onSelect: {
				await action {
					NavigationAction.setMainPage(page)
				}
				
			}
		)
	}
}
