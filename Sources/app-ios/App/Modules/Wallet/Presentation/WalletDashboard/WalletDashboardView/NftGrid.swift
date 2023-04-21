import TonkUI

struct NftGrid: View {
	
	let nfts: [Numbered<NonFungibleToken>]
	
	private let columns: [GridItem] = [
		GridItem(.flexible(), spacing: 8),
		GridItem(.flexible(), spacing: 8),
		GridItem(.flexible(), spacing: 8)
	]
	
	var body: some View {
		LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
			ForEach(nfts) { nft in
				Cell(nft: nft.element)
			}
		}
	}
	
	
	
	struct Cell: View {
		let nft: NonFungibleToken
		
		var body: some View {
			NonFungibleTokenCell(nft: nft)
				//.drawingGroup()
		}
		
		@ViewBuilder
		private func NonFungibleTokenCell(nft: NonFungibleToken) -> some View {
			VStack(spacing: 0) {
				Image(nft.id.id)
					.resizable()
					.frame(width: 114, height: 114)
					.cornerRadius(20, corners: .topLeft)
					.cornerRadius(20, corners: .topRight)
				Color.tonSystemGroupedBackground
					.frame(width: 114, height: 52)
					.cornerRadius(20, corners: .bottomLeft)
					.cornerRadius(20, corners: .bottomRight)
					.overlay {
						Meta(nft)
					}
			}
			.drawingGroup()
		}
		
		@ViewBuilder
		private func Meta(_ nft: NonFungibleToken) -> some View {
			HStack {
				VStack(alignment: .leading) {
					Text(nft.name)
						.font(.montserrat(.subheadline))
						.fontWeight(.semibold)
						.lineLimit(1)
						.foregroundColor(.tonPrimaryLabel)
					Text(nft.name)
						.font(.montserrat(.callout))
						.fontWeight(.medium)
						.lineLimit(1)
						.foregroundColor(.tonSecondaryLabel)
				}
				Spacer()
			}
			.padding(.leading, 12)
			.padding(.trailing, 12)
		}
		
	}
	
	
}

