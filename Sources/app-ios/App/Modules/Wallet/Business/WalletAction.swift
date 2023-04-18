enum WalletAction: PerduxAction, EnumReflectable {
	case reloadAssetsInState([any WalletAsset])
}

