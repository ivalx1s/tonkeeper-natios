import Foundation

extension TonkeeperNatios {
    struct Info {
		static let appDisplayName = Bundle.main.object(forInfoDictionaryKey: "BundleBaseDisplayName") as? String ?? ""
        static let bundleVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        static let buildVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
}

