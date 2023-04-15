enum WalletAction: PerduxAction, EnumReflectable {
	case fillStateWithWalletAssets([any WalletAsset])
}

