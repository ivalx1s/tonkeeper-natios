struct BaseToken: BaseTokenRepresentable {
	let id: AssetIdentifier
	let name: String
	let balance: BaseUnit
	
	init(id: AssetIdentifier, name: String, balance: BaseUnit) {
		self.id = id
		self.name = name
		self.balance = balance
	}
}


struct FungibleToken: FungibleTokenRepresentable {
	let id: AssetIdentifier
	let name: String
	let balance: BaseUnit
	
	init(id: AssetIdentifier, name: String, balance: BaseUnit) {
		self.id = id
		self.name = name
		self.balance = balance
	}
}


struct NonFungibleToken: NonFungibleTokenRepresentable {
	let id: AssetIdentifier
	let name: String
	let balance: BaseUnit
	
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
	
	init(id: AssetIdentifier, name: String, balance: BaseUnit) {
		self.id = id
		self.name = name
		self.balance = balance
	}
}

