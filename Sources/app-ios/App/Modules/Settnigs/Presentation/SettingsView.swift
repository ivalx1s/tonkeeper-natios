import TonkUI


extension SettingsView {
	struct DebugStepper: View {
		
		let title: String
		let incrementAction: () async -> ()
		let decrementAction: () async -> ()
		
		var body: some View {
			HStack {
				Text(LocalizedStringKey(title))
					.font(.montserrat(.title3).monospacedDigit())
				Spacer()
				WalletActionButton(iconName: "icon_sell") {
					await decrementAction()
				}
				WalletActionButton(iconName: "icon_buy") {
					await incrementAction()
				}
			}
			.padding(.horizontal)
		}
		
	}
}

struct SettingsView: View {
	
	
	@EnvironmentObject private var walletDashboardViewState: WalletDashboardViewState
	
	var body: some View {
		_Settings()
	}
	
	
	
	@ViewBuilder
	private func _Settings() -> some View {
		
		VStack {
			HStack {
				Spacer()
			}
			
			Spacer()
			DebugStepper(
				title: "\(Double(walletDashboardViewState.fungibleTokens.count).stringDescription(minimumIntegerDigits: 3, fractionDigits: 0)) Fungible Tokens",
				incrementAction: {
					await action {
						WalletSideEffect.addRandomFungibleToken
					}
				},
				decrementAction: {
					await action {
						WalletSideEffect.deleteRandomFungibleToken
					}
				})
			DebugStepper(title: "\(Double(walletDashboardViewState.nonFungibleTokens.count).stringDescription(minimumIntegerDigits: 3, fractionDigits: 0)) NonFungible Token", incrementAction: {
				await action {
					WalletSideEffect.addRandomNonFungibleToken
				}
			}, decrementAction: {
				await action {
					WalletSideEffect.deleteRandomNonFungibleToken
				}
			})
			
			DebugStepper(title: "\(Double(walletDashboardViewState.nonLiquidAssets.count).stringDescription(minimumIntegerDigits: 3, fractionDigits: 0)) NonLiquid Asset", incrementAction: {
				await action {
					WalletSideEffect.addRandomNonLiquidAsset
				}
			}, decrementAction: {
				await action {
					WalletSideEffect.deleteRandomNonLiquidAsset
				}
			})
				
			Button(action: {
				AppHelper.openAppSettings()
			}) {
				Text("Localization Settings")
			}
			.padding(.top)
			Spacer()
		}
	}
	
	
}

extension SettingsView {
	struct WalletActionButton: View {
		let iconName: String
		let action: () async -> ()
		
		@ViewBuilder
		var body: some View {
			_WalletActionButton(iconName: iconName, action: action)
		}
		
		@ViewBuilder
		private func _WalletActionButton(iconName: String, action: @escaping () async -> ()) -> some View {
			AsyncButton(action: {
				await action()
			} ) {
				Image(iconName)
			}
			.buttonStyle(.walletAction)
		}
	}
}

