protocol FungibleTokenRepresentable: WalletAsset {
	var symbol: String { get }
}
extension FungibleTokenRepresentable {
	var assetType: WalletAssetType {
		.fungibleToken
	}
}
