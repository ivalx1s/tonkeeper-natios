import Combine

@MainActor
final class WalletDashboardViewState: PerduxViewState {
	
//	@Published var
	
	init(/* required business states*/) {
		Task {
			await initPipelines()
		}
	}
	
	private func initPipelines() async  {

	}
}

