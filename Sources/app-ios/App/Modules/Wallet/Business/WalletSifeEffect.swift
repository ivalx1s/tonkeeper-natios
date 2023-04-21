
enum WalletSideEffect: PerduxEffect {
	case loadStubWalletAssets
	case loadStubDataInBuffer
	case addRandomFungibleToken
	case addAllAssets
	case deleteAllAssets
	case deleteRandomFungibleToken
	
	case addRandomNonFungibleToken
	case deleteRandomNonFungibleToken
	case addRandomNonLiquidAsset
	case deleteRandomNonLiquidAsset
}

