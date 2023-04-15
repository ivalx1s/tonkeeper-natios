	protocol FungibleTokenRepresentable: WalletAsset {}
	extension FungibleTokenRepresentable {
		var assetType: WalletAssetType {
			.fungibleToken
		}
	}
