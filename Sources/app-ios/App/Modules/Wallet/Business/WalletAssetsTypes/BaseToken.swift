

protocol BaseTokenRepresentable: WalletAsset {
	
}

extension BaseTokenRepresentable {
	var assetType: WalletAssetType {
		.baseToken
	}
}
