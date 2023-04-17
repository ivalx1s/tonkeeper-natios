enum WalletAssetType: CaseIterable, Equatable, Hashable, Comparable, Identifiable, Codable {
	case fungibleToken
	case nonFungibleToken
	case nonLiquidAsset
	
	var id: String {
		switch self {
			case .fungibleToken:
				return "fungibleToken"
			case .nonFungibleToken:
				return "nonFungibleToken"
			case .nonLiquidAsset:
				return "nonLiquidAsset"
		}
	}
	
	var rawValue: String {
		switch self {
			case .fungibleToken:
				return "fungibleToken"
			case .nonFungibleToken:
				return "nonFungibleToken"
			case .nonLiquidAsset:
				return "nonLiquidAsset"
		}
	}
}
