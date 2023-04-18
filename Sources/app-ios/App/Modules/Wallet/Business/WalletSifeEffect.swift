
enum WalletSideEffect: PerduxEffect {
	case loadStubWalletAssets
	case loadStubDataInBuffer
	case addRandomFungibleToken
	case deleteRandomFungibleToken
	
	case addRandomNonFungibleToken
	case deleteRandomNonFungibleToken
	case addRandomNonLiquidAsset
	case deleteRandomNonLiquidAsset
}

