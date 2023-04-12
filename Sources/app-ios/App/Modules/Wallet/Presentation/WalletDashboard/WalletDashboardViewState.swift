import Combine

@MainActor
final class WalletDashboardViewState: PerduxViewState {
	
	init(/* required business states*/) {
		Task {
			await initPipelines()
		}
	}
	
	private func initPipelines() async  {

	}
}

