
enum WalletSideEffect: PerduxEffect {
	case loadWalletAssets
	case addRandomFungibleToken
	case deleteRandomFungibleToken
	
	case addRandomNonFungibleToken
	case deleteRandomNonFungibleToken
	case addRandomNonLiquidAsset
	case deleteRandomNonLiquidAsset
}

