
import SwiftUI

extension WalletDashboardContainer {
	struct Props: DynamicProperty {
		@Binding var isPresentInRootContainer: Bool
		@Binding var walletDashboardPageIsActiveInParentContainer: Bool
		@Binding var walletScannerPageIsActiveIsPresentInParentContainer: Bool
		let subpage: MainPage.Wallet
	}
}

struct WalletDashboardContainer: View {
	
	@Binding var isPresentInRootContainer: Bool
	let props: Props
	
	@Environment(\.bounds) private var bounds
	
	@EnvironmentObject private var navState: NavigationViewState
	@EnvironmentObject private var walletDashboardViewState: WalletDashboardViewState
	@EnvironmentObject private var namespaceState: AnimationNamespaceState
	
	@ViewBuilder
	var body: some View {
		Content()
	}
	
	@ViewBuilder
	private func Content() -> some View {
		WalletDashboardView(
			isActiveInParentContainer: $isPresentInRootContainer,
			props: .init(
				isActiveInParentContainer: $isPresentInRootContainer
			),
			actions: .init(
			
			),
			states: .init(
				namespaceState: namespaceState,
				dashboardState: walletDashboardViewState
			)
		)
	}
}
