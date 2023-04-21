protocol WalletAsset: Sendable, Identifiable, Equatable, Codable, Hashable {
	var assetId: AssetIdentifier { get }
	var assetType: WalletAssetType { get }
	var name: String { get }
	var balance: BaseUnit { get }
}


struct BaseUnit: Sendable, Equatable, Codable, Hashable, Comparable {
	
	let amount: UInt
	let symbol: String
	let decimals: UInt
	
	var uiUnits: Double {
		Double(amount) / pow(10, Double(decimals))
	}
	
	init(amount: UInt, symbol: String, decimals: UInt) {
		self.amount = amount
		self.symbol = symbol
		self.decimals = decimals
	}
	
	static func < (lhs: BaseUnit, rhs: BaseUnit) -> Bool {
		lhs.amount < rhs.amount
	}
}
