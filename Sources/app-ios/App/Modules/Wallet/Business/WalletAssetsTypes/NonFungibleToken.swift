protocol NonFungibleTokenRepresentable: WalletAsset {}
extension NonFungibleTokenRepresentable {
	var assetType: WalletAssetType {
		.nonFungibleToken
	}
}
