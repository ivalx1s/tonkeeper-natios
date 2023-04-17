import TonkUI

struct FungibleTokenListRow: View {
	
	@Environment(\.locale) private var locale
	
	let element: FungibleToken
	let idx: Int
	let isFirst: Bool
	let isLast: Bool
	
	var body: some View {
		_NonNftTokenListRow(element: element, idx: idx, isFirst: isFirst, isLast: isLast)
	}
	@ViewBuilder
	func _NonNftTokenListRow(
		element: FungibleToken,
		idx: Int,
		isFirst: Bool,
		isLast: Bool
	) -> some View {
		HStack(spacing: 0) {
			Circle()
				.fill(Color.tonSecondarySystemBackground)
				.frame(width: 44, height: 44)
			VStack(alignment: .leading, spacing: 4) {
				HStack(spacing: 4) {
					Text(element.name)
						.font(.montserrat(.headline))
						.foregroundColor(.tonPrimaryLabel)
					Text(element.symbol)
						.font(.montserrat(.headline))
						.foregroundColor(.tonTertiaryLabel)
				}
				HStack(spacing: 3) {
					HStack(spacing: 0) {
						Text("$")
							.font(.montserrat(.subheadline))
							.foregroundColor(.tonSecondaryLabel)
							.padding(.trailing, 3)
						Text("\(element.stubPricePerUnit.stringDescription(fractionDigits: 2)) ")
							.font(.montserrat(.subheadline))
							.foregroundColor(.tonSecondaryLabel)
					}
					HStack(spacing: 0) {
						if Bool.random() {
							HStack(spacing: 0) {
								let isGain: Bool = .random()
								if isGain {
									Text("+")
										.font(.montserrat(.subheadline))
										.foregroundColor(.tonBalanceRelativeGain(forLocale: locale))
								} else {
									Text("-")
										.font(.montserrat(.subheadline))
										.foregroundColor(.tonBalanceRelativeLose(forLocale: locale))
								}
								Text("\(Double.random(in: 0...15).stringDescription(fractionDigits: 2))")
									.font(.montserrat(.subheadline))
									.foregroundColor(isGain ? .tonBalanceRelativeGain(forLocale: locale) : .tonBalanceRelativeLose(forLocale: locale))
								Text("%")
									.padding(.leading, 3)
									.font(.montserrat(.subheadline))
									.foregroundColor(isGain ? .tonBalanceRelativeGain(forLocale: locale) : .tonBalanceRelativeLose(forLocale: locale))
							}
						}
					}
				}
			}
			.padding(.leading, 16)
			Spacer()
			VStack(alignment: .trailing, spacing: 8) {
				Text("\(element.balance.uiUnits.stringDescription(fractionDigits: 2)) ")
					.font(.montserrat(.headline))
					.foregroundColor(.tonPrimaryLabel)
					.padding(.trailing, -4)
				HStack(spacing: 0) {
					Text("$")
						.font(.montserrat(.subheadline))
						.foregroundColor(.tonSecondaryLabel)
						.padding(.trailing, 3)
					Text("\((element.stubPricePerUnit*element.balance.uiUnits).stringDescription(fractionDigits: 2))")
						.font(.montserrat(.subheadline))
						.foregroundColor(.tonSecondaryLabel)
				}
			}
		}
		.padding()
		.background(WalletListRowBackground(isFirst: isFirst, isLast: isLast))
		.drawingGroup()
		.padding(.horizontal)
	}

}

