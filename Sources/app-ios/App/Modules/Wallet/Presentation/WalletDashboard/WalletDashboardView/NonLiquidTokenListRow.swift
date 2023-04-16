import TonkUI


#warning("think about aggregating FungibleToken and NLA")
struct NonLiquidTokenListRow: View {
	
	@Environment(\.locale) private var locale
	
	let element: NonLiquidAsset
	let idx: Int
	let isFirst: Bool
	let isLast: Bool
	
	var body: some View {
		_NonNftTokenListRow(element: element, idx: idx, isFirst: isFirst, isLast: isLast)
	}
	@ViewBuilder
	func _NonNftTokenListRow(
		element: NonLiquidAsset,
		idx: Int,
		isFirst: Bool,
		isLast: Bool
	) -> some View {
		HStack(spacing: 0) {
			Circle()
				.fill(Color.tonSecondarySystemBackground)
				.frame(width: 44, height: 44)
			VStack(alignment: .leading, spacing: 4) {
				Text(element.name)
					.font(.montserrat(.headline))
					.foregroundColor(.tonPrimaryLabel)
					
				Text(element.description)
					.font(.montserrat(.subheadline))
					.foregroundColor(.tonSecondaryLabel)
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
		.padding(.horizontal)
	}
	
}

