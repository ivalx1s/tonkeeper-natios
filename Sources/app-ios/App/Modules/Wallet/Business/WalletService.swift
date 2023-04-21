
actor WalletAssetsStub {
	private(set) var assets: [any WalletAsset] = []
	
	
	func setAssets(_ assets: [any WalletAsset]) {
		self.assets = assets
	}
	
	func append(_ asset: any WalletAsset) {
		self.assets.append(asset)
	}
	
	func remove(at idx: Int) {
		self.assets.remove(at: idx)
	}
	
	func removeAll() {
		self.assets = []
	}
	
	func append(contentsOf assets: [any WalletAsset]) {
		self.assets.append(contentsOf: assets)
	}
	
	func deleteRandomAsset(ofType assetType: WalletAssetType) {
		guard assets.isNotEmpty else {
			return
		}
		
		
		guard let randomAssetToDelete = try? assets(ofType: assetType).randomElement() else {
			return
		}
		
		if let index = assets.firstIndex(where: { $0.assetId == randomAssetToDelete.assetId }) {
			assets.remove(at: index)
		}
	}
	
	
	func assets(ofType assetType: WalletAssetType) throws -> [any WalletAsset] {
		guard assets.isNotEmpty else {
			throw WalletAssetStoreError.storeIsEmpty
		}
		
		let filteredAssets = assets.filter { asset in
			return asset.assetType == assetType
		}
		
		return filteredAssets
	}
	
	func randomAsset(ofType assetType: WalletAssetType) -> (any WalletAsset)? {
		try? assets(ofType: assetType).randomElement()
	}
	
	enum WalletAssetStoreError: Error {
		case storeIsEmpty
		case noAssetOfSpecifiedCategory
	}
}

fileprivate var tonAsset: any WalletAsset = FungibleToken(
	id: AssetIdentifier(id: "0"),
	name: "Toncoin",
	symbol: "TON",
	balance: BaseUnit(amount: 4343103000000,
					  symbol: "TON",
					  decimals: 9),
	stubPricePerUnit: 2.34
)


protocol IWalletService {
	func loadStubData() async
	func loadStubDataInBuffer() async
	func assets() async -> [any WalletAsset]
	func addRandomAsset(ofType type: WalletAssetType) async
	func addAllStubAssets() async
	func deleteAllAssets() async
	func deleteRandomAsset(of assetType: WalletAssetType) async
}

final class WalletService: IWalletService {
	
	
	private let walletAssets: WalletAssetsStub = .init()
	private let walletAssetsBuffer: WalletAssetsStub = .init()
	
	func assets() async -> [any WalletAsset]  {
		await walletAssets.assets
	}
	
	func loadStubData() async {
		await walletAssets.append(tonAsset)
//		await walletAssets.append(contentsOf: Self._walletHybridAssets)
//		await walletAssets.append(contentsOf: Self._walletHybridNftNltAssets)
	}
	
	func loadStubDataInBuffer() async {
//		let stubData0 = try! JSONDecoder().decode([FungibleToken].self, from:stubData0.data(using: .utf8)!)
		let fungibleTokens = try! JSONDecoder().decode([FungibleToken].self, from: fungibleTokens.data(using: .utf8)!)
		let nonLiquidAsset = Self._walletNonLiquidAssetsBuffer
		let nftAssets = Self._walletNftAssetsBuffer
		await walletAssetsBuffer.append(contentsOf: nonLiquidAsset)
		await walletAssetsBuffer.append(contentsOf: fungibleTokens)
		await walletAssetsBuffer.append(contentsOf: nftAssets)
	}
	
	func deleteRandomAsset(of assetType: WalletAssetType) async {
		await walletAssets.deleteRandomAsset(ofType: assetType)
	}
	
	func addRandomAsset(ofType type: WalletAssetType) async {
		if let asset = await walletAssetsBuffer.randomAsset(ofType: type) {
			await walletAssets.append(asset)
			if let idx = await walletAssetsBuffer.assets.firstIndex(where: { $0.assetId == asset.assetId }) {
				await walletAssetsBuffer.remove(at: idx)
			}
		}
	}
	
	func addAllStubAssets() async {
		await walletAssets.append(contentsOf: await walletAssetsBuffer.assets)
	}
	
	func deleteAllAssets() async {
		await walletAssets.removeAll()
	}
}
