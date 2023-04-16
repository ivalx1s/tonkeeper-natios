struct FungibleToken: FungibleTokenRepresentable {
	let id: AssetIdentifier
	let name: String
	let symbol: String
	let balance: BaseUnit
	let stubPricePerUnit: Double
	
	var assetId: AssetIdentifier {
		id
	}
	
	init(id: AssetIdentifier, name: String, symbol: String, balance: BaseUnit, stubPricePerUnit: Double) {
		self.id = id
		self.name = name
		self.symbol = symbol
		self.balance = balance
		self.stubPricePerUnit = stubPricePerUnit
	}
}


struct NonFungibleToken: NonFungibleTokenRepresentable {
	let id: AssetIdentifier
	let name: String
	let balance: BaseUnit
	
	var assetId: AssetIdentifier {
		id
	}
	
	init(id: AssetIdentifier, name: String, balance: BaseUnit) {
		self.id = id
		self.name = name
		self.balance = balance
	}
}


struct NonLiquidAsset: NonLiquidAssetRepresentable {
	let id: AssetIdentifier
	let name: String
	let balance: BaseUnit
	let description: String
	let stubPricePerUnit: Double
	
	var assetId: AssetIdentifier {
		id
	}
	
	init(id: AssetIdentifier, name: String, description: String, balance: BaseUnit, stubPricePerUnit: Double) {
		self.id = id
		self.name = name
		self.balance = balance
		self.description = description
		self.stubPricePerUnit = stubPricePerUnit
	}
}

