import TonkUI

struct SettingsView: View {
	
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
			HStack {
				WalletActionButton(iconName: "icon_buy", actionName: "Add Fungible Token") {
					await action {
						WalletSideEffect.addRandomFungibleToken
					}
				}
				WalletActionButton(iconName: "icon_sell", actionName: "Remove Fungible Token") {
					await action {
						WalletSideEffect.deleteRandomFungibleToken
					}
				}
			}
			HStack {
				WalletActionButton(iconName: "icon_buy", actionName: "Add NonFungible Token") {
					await action {
						WalletSideEffect.addRandomNonFungibleToken
					}
				}
				WalletActionButton(iconName: "icon_sell", actionName: "Remove NonFungible Token") {
					await action {
						WalletSideEffect.deleteRandomNonFungibleToken
					}
				}
			}
			
			HStack {
				WalletActionButton(iconName: "icon_buy", actionName: "Add NonLiquid Asset") {
					await action {
						WalletSideEffect.addRandomNonLiquidAsset
					}
				}
				WalletActionButton(iconName: "icon_sell", actionName: "Remove NonLiquid Asset") {
					await action {
						WalletSideEffect.deleteRandomNonLiquidAsset
					}
				}
				
			}
			Button(action: {
				AppHelper.openAppSettings()
			}) {
				Text("Localization Settings")
			}
			.padding(.top)
			Spacer()
		}
	}
	
	@ViewBuilder
	private func WalletActionButton(iconName: String, actionName: String,  action: @escaping () async -> ()) -> some View {
		VStack(alignment: .center, spacing: 8) {
			AsyncButton(action: {
				await action()
			} ) {
				Image(iconName)
			}
			.buttonStyle(.walletAction)
			Text(LocalizedStringKey(actionName))
				.font(.montserrat(.callout))
				.foregroundColor(.tonSecondaryLabel)
		}
	}
}


