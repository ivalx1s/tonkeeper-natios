protocol NonLiquidAssetRepresentable: WalletAsset {}
extension NonLiquidAssetRepresentable {
	var assetType: WalletAssetType {
		.nonLiquidAsset
	}
}
