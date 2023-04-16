

fileprivate var walletAssets: [any WalletAsset] = [
	FungibleToken(id: AssetIdentifier(id: "0"), name: "Toncoin", symbol: "TON", balance: BaseUnit(amount: 4343103000000, symbol: "TON", decimals: 9), stubPricePerUnit: 2.34),
]

fileprivate var walletAssetsBuffer: [any WalletAsset] = [
	FungibleToken(id: AssetIdentifier(id: "315"), name: "NeptuneToken", symbol: "NPT", balance: BaseUnit(amount: 500000000, symbol: "NPT", decimals: 8), stubPricePerUnit: 0.035),
	FungibleToken(id: AssetIdentifier(id: "316"), name: "JupiterCoin", symbol: "JPC", balance: BaseUnit(amount: 1500000000, symbol: "JPC", decimals: 8), stubPricePerUnit: 0.012),
	FungibleToken(id: AssetIdentifier(id: "317"), name: "MarsCash", symbol: "MRC", balance: BaseUnit(amount: 300000000, symbol: "MRC", decimals: 6), stubPricePerUnit: 0.002),
	FungibleToken(id: AssetIdentifier(id: "318"), name: "SaturnStable", symbol: "STS", balance: BaseUnit(amount: 10000000, symbol: "STS", decimals: 6), stubPricePerUnit: 1.0),
	FungibleToken(id: AssetIdentifier(id: "319"), name: "UranusUtility", symbol: "UUT", balance: BaseUnit(amount: 2000000000, symbol: "UUT", decimals: 8), stubPricePerUnit: 0.016),
	FungibleToken(id: AssetIdentifier(id: "320"), name: "GalaxyGold", symbol: "GLX", balance: BaseUnit(amount: 5000000, symbol: "GLX", decimals: 4), stubPricePerUnit: 50.0),
	FungibleToken(id: AssetIdentifier(id: "321"), name: "SolarSilver", symbol: "SLS", balance: BaseUnit(amount: 10000000, symbol: "SLS", decimals: 4), stubPricePerUnit: 25.0),
	FungibleToken(id: AssetIdentifier(id: "322"), name: "CosmicCopper", symbol: "CSC", balance: BaseUnit(amount: 25000000, symbol: "CSC", decimals: 4), stubPricePerUnit: 10.0),
	FungibleToken(id: AssetIdentifier(id: "323"), name: "AsteroidAlloy", symbol: "ASA", balance: BaseUnit(amount: 200000000, symbol: "ASA", decimals: 6), stubPricePerUnit: 1.5),
	FungibleToken(id: AssetIdentifier(id: "324"), name: "MoonMinerals", symbol: "MMN", balance: BaseUnit(amount: 500000000, symbol: "MMN", decimals: 6), stubPricePerUnit: 0.045),
	FungibleToken(id: AssetIdentifier(id: "325"), name: "OrbitalOil", symbol: "OBO", balance: BaseUnit(amount: 1000000000, symbol: "OBO", decimals: 8), stubPricePerUnit: 0.03),
	FungibleToken(id: AssetIdentifier(id: "326"), name: "StarshipSteel", symbol: "STS", balance: BaseUnit(amount: 300000000, symbol: "STS", decimals: 6), stubPricePerUnit: 2.5),
	FungibleToken(id: AssetIdentifier(id: "327"), name: "NebulaNickel", symbol: "NBN", balance: BaseUnit(amount: 1000000000, symbol: "NBN", decimals: 6), stubPricePerUnit: 2.5),
	FungibleToken(id: AssetIdentifier(id: "34"), name: "Imaginary Coin", symbol: "IMC", balance: BaseUnit(amount: 123456000, symbol: "IMC", decimals: 6), stubPricePerUnit: 0.01),
	FungibleToken(id: AssetIdentifier(id: "35"), name: "Fiction Token", symbol: "FTK", balance: BaseUnit(amount: 7890000, symbol: "FTK", decimals: 4), stubPricePerUnit: 3.45),
	FungibleToken(id: AssetIdentifier(id: "36"), name: "Mythical Dollar", symbol: "MYD", balance: BaseUnit(amount: 550000, symbol: "MYD", decimals: 2), stubPricePerUnit: 0.5),
	FungibleToken(id: AssetIdentifier(id: "328"), name: "AlphaToken", symbol: "APT", balance: BaseUnit(amount: 6000000000, symbol: "APT", decimals: 8), stubPricePerUnit: 0.078),
	FungibleToken(id: AssetIdentifier(id: "329"), name: "BetaCoin", symbol: "BTC", balance: BaseUnit(amount: 900000000, symbol: "BTC", decimals: 6), stubPricePerUnit: 0.058),
	FungibleToken(id: AssetIdentifier(id: "330"), name: "GammaCash", symbol: "GMC", balance: BaseUnit(amount: 250000000, symbol: "GMC", decimals: 6), stubPricePerUnit: 0.025),
	FungibleToken(id: AssetIdentifier(id: "331"), name: "DeltaDollar", symbol: "DTD", balance: BaseUnit(amount: 20000000, symbol: "DTD", decimals: 6), stubPricePerUnit: 1.01),
	FungibleToken(id: AssetIdentifier(id: "332"), name: "EpsilonEnergy", symbol: "EPE", balance: BaseUnit(amount: 1500000000, symbol: "EPE", decimals: 8), stubPricePerUnit: 0.032),
	FungibleToken(id: AssetIdentifier(id: "333"), name: "ZetaZinc", symbol: "ZZC", balance: BaseUnit(amount: 4000000, symbol: "ZZC", decimals: 4), stubPricePerUnit: 4.5),
	FungibleToken(id: AssetIdentifier(id: "334"), name: "EtaEthereum", symbol: "ETE", balance: BaseUnit(amount: 10000000, symbol: "ETE", decimals: 6), stubPricePerUnit: 6.0),
	FungibleToken(id: AssetIdentifier(id: "335"), name: "ThetaTitanium", symbol: "TTA", balance: BaseUnit(amount: 20000000, symbol: "TTA", decimals: 6), stubPricePerUnit: 9.0),
	FungibleToken(id: AssetIdentifier(id: "336"), name: "IotaIridium", symbol: "IRI", balance: BaseUnit(amount: 500000000, symbol: "IRI", decimals: 6), stubPricePerUnit: 0.075),
	FungibleToken(id: AssetIdentifier(id: "337"), name: "KappaKrypton", symbol: "KPT", balance: BaseUnit(amount: 300000000, symbol: "KPT", decimals: 6), stubPricePerUnit: 0.12),
	FungibleToken(id: AssetIdentifier(id: "338"), name: "LambdaLithium", symbol: "LTH", balance: BaseUnit(amount: 4000000000, symbol: "LTH", decimals: 8), stubPricePerUnit: 0.045),
	FungibleToken(id: AssetIdentifier(id: "339"), name: "MuMagnesium", symbol: "MGM", balance: BaseUnit(amount: 200000000, symbol: "MGM", decimals: 6), stubPricePerUnit: 0.6),
	FungibleToken(id: AssetIdentifier(id: "1"), name: "DAI", symbol: "DAI", balance: BaseUnit(amount: 5045000000, symbol: "DAI", decimals: 6), stubPricePerUnit: 0.999),
	FungibleToken(id: AssetIdentifier(id: "2"), name: "USD Coin", symbol: "USDC", balance: BaseUnit(amount: 50000000, symbol: "USDC", decimals: 6), stubPricePerUnit: 1.0),
	FungibleToken(id: AssetIdentifier(id: "3"), name: "Tether", symbol: "USDT", balance: BaseUnit(amount: 122000000, symbol: "USDT", decimals: 6), stubPricePerUnit: 0.6),
	FungibleToken(id: AssetIdentifier(id: "4"), name: "Binance USD", symbol: "BUSD", balance: BaseUnit(amount: 30000, symbol: "BUSD", decimals: 6), stubPricePerUnit: 0.7),
	FungibleToken(id: AssetIdentifier(id: "5"), name: "PAX", symbol: "BUSD", balance: BaseUnit(amount: 151230000, symbol: "PAX", decimals: 6), stubPricePerUnit: 1.0),
	FungibleToken(id: AssetIdentifier(id: "17"), name: "Paxos Gold", symbol: "PAXG", balance: BaseUnit(amount: 20, symbol: "PAXG", decimals: 1), stubPricePerUnit: 2020),
	FungibleToken(id: AssetIdentifier(id: "19"), name: "Imaginary Token", symbol: "IMG", balance: BaseUnit(amount: 250000, symbol: "IMG", decimals: 18), stubPricePerUnit: 0.01),
	FungibleToken(id: AssetIdentifier(id: "20"), name: "Fictional Token", symbol: "FIC", balance: BaseUnit(amount: 1000000, symbol: "FIC", decimals: 8), stubPricePerUnit: 0.2),
	FungibleToken(id: AssetIdentifier(id: "21"), name: "Mythical Coin", symbol: "MYTH", balance: BaseUnit(amount: 75000, symbol: "MYTH", decimals: 12), stubPricePerUnit: 0.5),
	FungibleToken(id: AssetIdentifier(id: "22"), name: "Fantasy Coin", symbol: "FAN", balance: BaseUnit(amount: 500000, symbol: "FAN", decimals: 16), stubPricePerUnit: 0.05),
	FungibleToken(id: AssetIdentifier(id: "23"), name: "Dream Token", symbol: "DREAM", balance: BaseUnit(amount: 10000000, symbol: "DREAM", decimals: 10), stubPricePerUnit: 0.005),
	NonFungibleToken(id: AssetIdentifier(id: "6"), name: "CryptoPunk", balance: BaseUnit(amount: 1, symbol: "CryptoPunk", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "7"), name: "Bored Ape Yacht Club", balance: BaseUnit(amount: 1, symbol: "BAYC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "8"), name: "World of Women", balance: BaseUnit(amount: 1, symbol: "WOW", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "9"), name: "Rumble Kong League", balance: BaseUnit(amount: 1, symbol: "RKL", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "10"), name: "Sevens", balance: BaseUnit(amount: 1, symbol: "Sevens", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "24"), name: "Imaginary Art", balance: BaseUnit(amount: 1, symbol: "IMGART", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "37"), name: "Imaginary Art", balance: BaseUnit(amount: 1, symbol: "IMA", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "38"), name: "Fictional Creatures", balance: BaseUnit(amount: 1, symbol: "FCR", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "39"), name: "Mythical Landscapes", balance: BaseUnit(amount: 1, symbol: "MLA", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "25"), name: "Fictional Character", balance: BaseUnit(amount: 1, symbol: "FICCHAR", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "26"), name: "Mythical Creature", balance: BaseUnit(amount: 1, symbol: "MYTHCRE", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "27"), name: "Fantasy Landscape", balance: BaseUnit(amount: 1, symbol: "FANLAND", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "28"), name: "Dream World", balance: BaseUnit(amount: 1, symbol: "DREAMW", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "16"), name: "Eights", balance: BaseUnit(amount: 1, symbol: "Eights", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "120"), name: "Cool Cats", balance: BaseUnit(amount: 1, symbol: "CC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "121"), name: "DegenApes", balance: BaseUnit(amount: 1, symbol: "DA", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "122"), name: "MetaHeroes", balance: BaseUnit(amount: 1, symbol: "MH", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "123"), name: "ArtBlocks", balance: BaseUnit(amount: 1, symbol: "AB", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "124"), name: "Mutant Ape Yacht Club", balance: BaseUnit(amount: 1, symbol: "MAYC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "125"), name: "Galaxy Eggs", balance: BaseUnit(amount: 1, symbol: "GE", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "126"), name: "Pudgy Penguins", balance: BaseUnit(amount: 1, symbol: "PP", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "127"), name: "PixelPandas", balance: BaseUnit(amount: 1, symbol: "PxP", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "128"), name: "CryptoCats", balance: BaseUnit(amount: 1, symbol: "CC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "129"), name: "CryptoDogs", balance: BaseUnit(amount: 1, symbol: "CD", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "130"), name: "AI-Generated Art", balance: BaseUnit(amount: 1, symbol: "AIA", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "131"), name: "DreamPunks", balance: BaseUnit(amount: 1, symbol: "DP", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "132"), name: "AstroBeasts", balance: BaseUnit(amount: 1, symbol: "AB", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "133"), name: "SuperMeebits", balance: BaseUnit(amount: 1, symbol: "SM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "134"), name: "CyberKongs", balance: BaseUnit(amount: 1, symbol: "CK", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "135"), name: "ZombieToads", balance: BaseUnit(amount: 1, symbol: "ZT", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "136"), name: "CosmicCows", balance: BaseUnit(amount: 1, symbol: "CC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "137"), name: "SpaceGiraffes", balance: BaseUnit(amount: 1, symbol: "SG", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "138"), name: "AlienCacti", balance: BaseUnit(amount: 1, symbol: "AC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "139"), name: "MysticMonkeys", balance: BaseUnit(amount: 1, symbol: "MM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "140"), name: "CryptoDoggos", balance: BaseUnit(amount: 1, symbol: "CD", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "141"), name: "PixelPortraits", balance: BaseUnit(amount: 1, symbol: "PP", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "142"), name: "DigitalDragons", balance: BaseUnit(amount: 1, symbol: "DD", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "143"), name: "GalacticGeckos", balance: BaseUnit(amount: 1, symbol: "GG", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "144"), name: "VirtualVikings", balance: BaseUnit(amount: 1, symbol: "VV", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "145"), name: "RoboRabbits", balance: BaseUnit(amount: 1, symbol: "RR", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "146"), name: "CyberCats", balance: BaseUnit(amount: 1, symbol: "CC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "147"), name: "FantasyFrogs", balance: BaseUnit(amount: 1, symbol: "FF", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "148"), name: "DigitalDinosaurs", balance: BaseUnit(amount: 1, symbol: "DINO", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "149"), name: "ArtificialAntelopes", balance: BaseUnit(amount: 1, symbol: "AA", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "150"), name: "PixelPenguins", balance: BaseUnit(amount: 1, symbol: "PE", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "151"), name: "NeonNarwhals", balance: BaseUnit(amount: 1, symbol: "NN", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "152"), name: "SiliconSeahorses", balance: BaseUnit(amount: 1, symbol: "SS", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "153"), name: "TechnoTurtles", balance: BaseUnit(amount: 1, symbol: "TT", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "154"), name: "LaserLlamas", balance: BaseUnit(amount: 1, symbol: "LL", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "155"), name: "QuantumKoalas", balance: BaseUnit(amount: 1, symbol: "QK", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "156"), name: "HolographicHippos", balance: BaseUnit(amount: 1, symbol: "HH", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "157"), name: "ElectricElephants", balance: BaseUnit(amount: 1, symbol: "EE", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "158"), name: "CyberCapybaras", balance: BaseUnit(amount: 1, symbol: "CB", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "159"), name: "DigitalDolphins", balance: BaseUnit(amount: 1, symbol: "DO", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "160"), name: "RoboticRaccoons", balance: BaseUnit(amount: 1, symbol: "RC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "161"), name: "VirtualVampires", balance: BaseUnit(amount: 1, symbol: "VM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "162"), name: "NeuralNetworkNinjas", balance: BaseUnit(amount: 1, symbol: "NNN", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "163"), name: "PixelPirates", balance: BaseUnit(amount: 1, symbol: "PI", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "164"), name: "CryptoCentaurs", balance: BaseUnit(amount: 1, symbol: "CT", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "165"), name: "SiliconSamurais", balance: BaseUnit(amount: 1, symbol: "SM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "166"), name: "DigitalDemons", balance: BaseUnit(amount: 1, symbol: "DM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "167"), name: "TechnoTitans", balance: BaseUnit(amount: 1, symbol: "TN", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "168"), name: "LaserLeprechauns", balance: BaseUnit(amount: 1, symbol: "LP", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "169"), name: "QuantumQueens", balance: BaseUnit(amount: 1, symbol: "QQ", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "170"), name: "AstroAntelopes", balance: BaseUnit(amount: 1, symbol: "AA", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "171"), name: "GalacticGiraffes", balance: BaseUnit(amount: 1, symbol: "GG", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "172"), name: "InterstellarIguanas", balance: BaseUnit(amount: 1, symbol: "II", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "173"), name: "NebulaNarwhals", balance: BaseUnit(amount: 1, symbol: "NN", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "174"), name: "OrbitingOwls", balance: BaseUnit(amount: 1, symbol: "OO", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "175"), name: "SpaceSharks", balance: BaseUnit(amount: 1, symbol: "SS", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "176"), name: "CosmicCheetahs", balance: BaseUnit(amount: 1, symbol: "CC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "177"), name: "CelestialCobras", balance: BaseUnit(amount: 1, symbol: "CLC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "178"), name: "GravityGorillas", balance: BaseUnit(amount: 1, symbol: "GG", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "179"), name: "MeteorMonkeys", balance: BaseUnit(amount: 1, symbol: "MM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "180"), name: "SupernovaSloths", balance: BaseUnit(amount: 1, symbol: "SN", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "181"), name: "StellarSeahorses", balance: BaseUnit(amount: 1, symbol: "SS", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "182"), name: "EclipseEagles", balance: BaseUnit(amount: 1, symbol: "EE", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "183"), name: "MoonbeamMeerkats", balance: BaseUnit(amount: 1, symbol: "MM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "184"), name: "AuroraAlligators", balance: BaseUnit(amount: 1, symbol: "AA", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "185"), name: "CometCougars", balance: BaseUnit(amount: 1, symbol: "CC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "186"), name: "QuasarQuokkas", balance: BaseUnit(amount: 1, symbol: "QQ", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "187"), name: "GalaxyGeckos", balance: BaseUnit(amount: 1, symbol: "GG", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "188"), name: "PulsarPandas", balance: BaseUnit(amount: 1, symbol: "PP", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "189"), name: "StarlightSquirrels", balance: BaseUnit(amount: 1, symbol: "SS", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "190"), name: "NebulaNewts", balance: BaseUnit(amount: 1, symbol: "NN", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "191"), name: "BlackHoleBunnies", balance: BaseUnit(amount: 1, symbol: "BH", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "192"), name: "CosmicCats", balance: BaseUnit(amount: 1, symbol: "CC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "193"), name: "AsteroidArmadillos", balance: BaseUnit(amount: 1, symbol: "AA", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "194"), name: "DwarfStarDolphins", balance: BaseUnit(amount: 1, symbol: "DS", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "195"), name: "CelestialChameleons", balance: BaseUnit(amount: 1, symbol: "CC", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "196"), name: "SpaceSnakes", balance: BaseUnit(amount: 1, symbol: "SS", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "197"), name: "MoonlitMoles", balance: BaseUnit(amount: 1, symbol: "MM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "198"), name: "WormholeWalruses", balance: BaseUnit(amount: 1, symbol: "WW", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "199"), name: "SolarSalamanders", balance: BaseUnit(amount: 1, symbol: "SS", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "200"), name: "InterstellarIguanas", balance: BaseUnit(amount: 1, symbol: "II", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "201"), name: "MarsMeerkats", balance: BaseUnit(amount: 1, symbol: "MM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "202"), name: "PlanetPenguins", balance: BaseUnit(amount: 1, symbol: "PP", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "203"), name: "SupernovaSloths", balance: BaseUnit(amount: 1, symbol: "SS", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "204"), name: "ExoplanetEagles", balance: BaseUnit(amount: 1, symbol: "EE", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "205"), name: "GalacticGiraffes", balance: BaseUnit(amount: 1, symbol: "GG", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "206"), name: "OrbitingOwls", balance: BaseUnit(amount: 1, symbol: "OO", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "207"), name: "SpaceWhales", balance: BaseUnit(amount: 1, symbol: "SW", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "208"), name: "LunarLlamas", balance: BaseUnit(amount: 1, symbol: "LL", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "209"), name: "RedDwarfRabbits", balance: BaseUnit(amount: 1, symbol: "RD", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "210"), name: "GravityGorillas", balance: BaseUnit(amount: 1, symbol: "GG", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "211"), name: "SatelliteSharks", balance: BaseUnit(amount: 1, symbol: "SS", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "212"), name: "MeteorMonkeys", balance: BaseUnit(amount: 1, symbol: "MM", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "213"), name: "AuroraAlligators", balance: BaseUnit(amount: 1, symbol: "AA", decimals: 0)),
	NonFungibleToken(id: AssetIdentifier(id: "214"), name: "StellarStingrays", balance: BaseUnit(amount: 1, symbol: "SS", decimals: 0)),
	NonLiquidAsset(id: AssetIdentifier(id: "511"), name: "Ethereum 2.0 Staking", description: "Ethereum 2.0 Staking", balance: BaseUnit(amount: 5, symbol: "ETH2", decimals: 18), stubPricePerUnit: 13),
	NonLiquidAsset(id: AssetIdentifier(id: "512"), name: "Cardano Staking", description: "Cardano Staking", balance: BaseUnit(amount: 100000, symbol: "ADA", decimals: 6), stubPricePerUnit: 24),
	NonLiquidAsset(id: AssetIdentifier(id: "513"), name: "Solana Staking", description: "Solana Staking", balance: BaseUnit(amount: 250000, symbol: "SOL", decimals: 9), stubPricePerUnit: 944),
	NonLiquidAsset(id: AssetIdentifier(id: "514"), name: "Polkadot Staking", description: "Polkadot Staking", balance: BaseUnit(amount: 7500, symbol: "DOT", decimals: 10), stubPricePerUnit: 3),
	NonLiquidAsset(id: AssetIdentifier(id: "515"), name: "Algorand Staking", description: "Algorand", balance: BaseUnit(amount: 500000, symbol: "ALGO", decimals: 6), stubPricePerUnit: 2),
	NonLiquidAsset(id: AssetIdentifier(id: "518"), name: "ChainGPT Staking", description: "To The Moon", balance: BaseUnit(amount: 500000, symbol: "CGPTS", decimals: 6), stubPricePerUnit: 6),
	NonLiquidAsset(id: AssetIdentifier(id: "529"), name: "Imaginary Staking", description: "Staking Imaginary Tokens", balance: BaseUnit(amount: 1000, symbol: "IMG", decimals: 18), stubPricePerUnit: 0.01),
	NonLiquidAsset(id: AssetIdentifier(id: "530"), name: "Fictional Bond", description: "Fictional Token Bonds", balance: BaseUnit(amount: 500, symbol: "FICB", decimals: 6), stubPricePerUnit: 1000),
	NonLiquidAsset(id: AssetIdentifier(id: "540"), name: "Imaginary Staking", description: "Imaginary Coin Staking", balance: BaseUnit(amount: 10000, symbol: "IMCS", decimals: 6), stubPricePerUnit: 0.02),
	NonLiquidAsset(id: AssetIdentifier(id: "541"), name: "Fictional Savings", description: "Fiction Token Savings", balance: BaseUnit(amount: 2000, symbol: "FTKS", decimals: 4), stubPricePerUnit: 4),
	NonLiquidAsset(id: AssetIdentifier(id: "542"), name: "Mythical Vault", description: "Mythical Dollar High Yield Vault", balance: BaseUnit(amount: 100000, symbol: "MYDV", decimals: 2), stubPricePerUnit: 1),
	NonLiquidAsset(id: AssetIdentifier(id: "596"), name: "Startup Equity", description: "Startup Equity", balance: BaseUnit(amount: 100, symbol: "SE", decimals: 0), stubPricePerUnit: 600),
	NonLiquidAsset(id: AssetIdentifier(id: "597"), name: "Private Company Shares", description: "Private Company Shares", balance: BaseUnit(amount: 200, symbol: "PCS", decimals: 0), stubPricePerUnit: 600),
	NonLiquidAsset(id: AssetIdentifier(id: "598"), name: "Convertible Bonds", description: "Convertible Bonds", balance: BaseUnit(amount: 50, symbol: "CB", decimals: 0), stubPricePerUnit: 600),
	NonLiquidAsset(id: AssetIdentifier(id: "599"), name: "Venture Capital Fund", description: "Venture Capital Fund", balance: BaseUnit(amount: 10, symbol: "VCF", decimals: 0), stubPricePerUnit: 10000),
	NonLiquidAsset(id: AssetIdentifier(id: "600"), name: "Limited Partnership", description: "Limited Partnership", balance: BaseUnit(amount: 5, symbol: "LP", decimals: 0), stubPricePerUnit: 15000),
	NonLiquidAsset(id: AssetIdentifier(id: "601"), name: "Hedge Fund", description: "Hedge Fund", balance: BaseUnit(amount: 8, symbol: "HF", decimals: 0), stubPricePerUnit: 10000),
	NonLiquidAsset(id: AssetIdentifier(id: "602"), name: "Private Equity Fund", description: "Private Equity Fund", balance: BaseUnit(amount: 10, symbol: "PEF", decimals: 0), stubPricePerUnit: 9000),
	NonLiquidAsset(id: AssetIdentifier(id: "603"), name: "Peer-to-Peer Lending", description: "Peer-to-Peer Lending", balance: BaseUnit(amount: 1000, symbol: "P2P", decimals: 0), stubPricePerUnit: 50),
	NonLiquidAsset(id: AssetIdentifier(id: "604"), name: "Farm Land", description: "Farm Land", balance: BaseUnit(amount: 10, symbol: "FL", decimals: 0), stubPricePerUnit: 20000),
	NonLiquidAsset(id: AssetIdentifier(id: "605"), name: "Mobile Home Park", description: "Mobile Home Park", balance: BaseUnit(amount: 5, symbol: "MHP", decimals: 0), stubPricePerUnit: 60000),
	NonLiquidAsset(id: AssetIdentifier(id: "606"), name: "Self-Storage Facility", description: "Self-Storage Facility", balance: BaseUnit(amount: 2, symbol: "SSF", decimals: 0), stubPricePerUnit: 75000),
	NonLiquidAsset(id: AssetIdentifier(id: "607"), name: "Apartment Complex", description: "Apartment Complex", balance: BaseUnit(amount: 1, symbol: "AC", decimals: 0), stubPricePerUnit: 500000),
	NonLiquidAsset(id: AssetIdentifier(id: "608"), name: "Office Building", description: "Office Building", balance: BaseUnit(amount: 1, symbol: "OB", decimals: 0), stubPricePerUnit: 600000),
	NonLiquidAsset(id: AssetIdentifier(id: "609"), name: "Shopping Center", description: "Shopping Center", balance: BaseUnit(amount: 1, symbol: "SC", decimals: 0), stubPricePerUnit: 5000),
]

protocol IWalletService {
	func loadWalletAssets() async -> [any WalletAsset]
	func getRandomAsset(ofCategory: WalletAssetType) async -> (any WalletAsset)?
	func deleteRandomAsset(of assetType: WalletAssetType) async
}

final class WalletService: IWalletService {
	
	func loadWalletAssets() -> [any WalletAsset] {
		walletAssets
	}
	
	func deleteRandomAsset(of assetType: WalletAssetType) {
		let assetsOfCategory = walletAssets.indices.filter { walletAssets[$0].assetType == assetType }
		
		guard !assetsOfCategory.isEmpty else {
			return
		}
		
		let randomIndex = assetsOfCategory.randomElement()!
		print(walletAssets)
		walletAssets.remove(at: randomIndex)
		print(walletAssets)
	}
	
	func getRandomAsset(ofCategory category: WalletAssetType) -> (any WalletAsset)? {
		let assetsInCategory = walletAssetsBuffer.enumerated().filter { $0.element.assetType == category }
		
		guard !assetsInCategory.isEmpty else {
			return nil
		}
		
		let randomIndex = Int.random(in: 0..<assetsInCategory.count)
		let (originalIndex, randomAsset) = assetsInCategory[randomIndex]
		walletAssetsBuffer.remove(at: originalIndex)
		walletAssets.append(randomAsset)
		return randomAsset
	}
	
}
