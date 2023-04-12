
import SwiftUI

extension WalletDashboardContainer {
	struct Props: DynamicProperty {
		@Binding var isPresentInRootContainer: Bool
		let subpage: MainPage.Wallet
		@Binding var walletDashboardPageIsActiveInParentContainer: Bool
		@Binding var walletScannerPageIsActiveIsPresentInParentContainer: Bool
		@Binding var exerciseExercisePageInternalIsPresentInParentContainer: Bool
		@Binding var exerciseCooldownPageInternalIsPresentInParentContainer: Bool
	}
}

struct WalletDashboardContainer: View {
	
	@Binding var isActiveInParentContainer: Bool
	let subpage: MainPage.Wallet
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
			props: .init(
				isActiveInParentContainer: $isActiveInParentContainer
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
