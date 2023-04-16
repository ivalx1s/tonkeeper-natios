import TonkUI


struct WalletListRowBackground: View {
	
	let isFirst: Bool
	let isLast: Bool
	
	var body: some View {
		nonNftListRowBackground(isFirst: isFirst, isLast: isLast)
	}
	
	
	@ViewBuilder
	private func nonNftListRowBackground(isFirst: Bool, isLast: Bool) -> some View {
		switch (isFirst, isLast) {
			case (true, false):
				VStack(spacing: -1) {
					Color.tonSystemGroupedBackground
						.cornerRadius(20, corners: .topLeft)
						.cornerRadius(20, corners: .topRight)
					Rectangle()
						.frame(height: 1/2)
						.foregroundColor(.tonListSeparator)
						.offset(x: 16)
				}
				.clipped()
			case (false, false):
				VStack(spacing: -1) {
					Color.tonSystemGroupedBackground
					Rectangle()
						.frame(height: 1/2)
						.foregroundColor(.tonListSeparator)
						.offset(x: 16)
				}
				.clipped()
				
			case (false, true):
				Color.tonSystemGroupedBackground
					.cornerRadius(20, corners: .bottomLeft)
					.cornerRadius(20, corners: .bottomRight)
				
			case (true, true):
				// edge case for when we have only one row
				Color.tonSystemGroupedBackground
					.cornerRadius(20, corners: .topLeft)
					.cornerRadius(20, corners: .topRight)
					.cornerRadius(20, corners: .bottomLeft)
					.cornerRadius(20, corners: .bottomRight)
				
		}
	}

	
}

