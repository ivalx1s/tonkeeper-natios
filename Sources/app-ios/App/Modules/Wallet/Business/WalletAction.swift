enum WalletAction: PerduxAction, EnumReflectable {
	case fillStateWithWalletAssets([any WalletAsset])
	case addRandomAsset(any WalletAsset)
}

