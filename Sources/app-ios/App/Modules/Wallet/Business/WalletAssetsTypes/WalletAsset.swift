protocol WalletAsset: Sendable, Identifiable {
	var assetType: WalletAssetType { get }
	var name: String { get }
	var balance: BaseUnit { get }
}

struct BaseUnit: Sendable {
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
}
