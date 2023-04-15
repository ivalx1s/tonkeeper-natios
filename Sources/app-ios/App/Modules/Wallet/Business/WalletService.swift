
fileprivate let walletAssets: [any WalletAsset] = [
	FungibleToken(id: AssetIdentifier(id: "1"), name: "DAI", balance: BaseUnit(amount: 100000, symbol: "DAI", decimals: 18)),
	FungibleToken(id: AssetIdentifier(id: "2"), name: "USDC", balance: BaseUnit(amount: 50000, symbol: "USDC", decimals: 6)),
	FungibleToken(id: AssetIdentifier(id: "3"), name: "USDT", balance: BaseUnit(amount: 2000000, symbol: "USDT", decimals: 6)),
	FungibleToken(id: AssetIdentifier(id: "4"), name: "BUSD", balance: BaseUnit(amount: 30000, symbol: "BUSD", decimals: 18)),
	FungibleToken(id: AssetIdentifier(id: "5"), name: "PAX", balance: BaseUnit(amount: 150000, symbol: "PAX", decimals: 18)),
	FungibleToken(id: AssetIdentifier(id: "17"), name: "PAXG", balance: BaseUnit(amount: 150000, symbol: "PAXG", decimals: 18)),
	NonFungibleToken(id: AssetIdentifier(id: "6"), name: "CryptoPunk", balance: BaseUnit(amount: 1, symbol: "CryptoPunk", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "7"), name: "Bored Ape Yacht Club", balance: BaseUnit(amount: 1, symbol: "BAYC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "8"), name: "World of Women", balance: BaseUnit(amount: 1, symbol: "WOW", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "9"), name: "Rumble Kong League", balance: BaseUnit(amount: 1, symbol: "RKL", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "10"), name: "Sevens", balance: BaseUnit(amount: 1, symbol: "Sevens", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "16"), name: "Eights", balance: BaseUnit(amount: 1, symbol: "Eights", decimals: 0)),
	NonLiquidAsset(id: AssetIdentifier(id: "11"), name: "Ethereum 2.0 Staking", balance: BaseUnit(amount: 5, symbol: "ETH2", decimals: 18)),
	NonLiquidAsset(id: AssetIdentifier(id: "12"), name: "Cardano Staking", balance: BaseUnit(amount: 100000, symbol: "ADA", decimals: 6)),
	NonLiquidAsset(id: AssetIdentifier(id: "13"), name: "Solana Staking", balance: BaseUnit(amount: 250000, symbol: "SOL", decimals: 9)),
	NonLiquidAsset(id: AssetIdentifier(id: "14"), name: "Polkadot Staking", balance: BaseUnit(amount: 7500, symbol: "DOT", decimals: 10)),
	NonLiquidAsset(id: AssetIdentifier(id: "15"), name: "Algorand Staking", balance: BaseUnit(amount: 500000, symbol: "ALGO", decimals: 6)),
	NonLiquidAsset(id: AssetIdentifier(id: "18"), name: "ChainGPT Staking", balance: BaseUnit(amount: 500000, symbol: "CGPTS", decimals: 6)),
]

protocol IWalletService {
	func loadWalletAssets() -> [any WalletAsset]
}

final class WalletService: IWalletService {
	
	func loadWalletAssets() -> [any WalletAsset] {
		walletAssets
	}
	
}
