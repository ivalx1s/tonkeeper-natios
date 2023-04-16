import SwiftUI

extension Locale: Identifiable {
	
	/// For use within SwiftUI dynamic views
	///
	/// ❗️Don't use as locale identifier
	/// There is dedicated *identieir* property
	public var id: String {
		self.identifier
	}
}

extension Locale {
	
	private static var currentRegionCode: String {
		Self.current.language.region?.identifier ?? ""
	}
	
	static var en: Self {
		.init(identifier: "en")
	}
	static var ru: Self {
		.init(identifier: "ru")
	}

	
	
	///Returns an array of locale instances with preserved device region codes
	static var supportedAppLocales: [Locale] {
		[
			.en,
			.ru,
		]
	}
	
	///Returns a proper layout direction for a given ISO 639-1 language
	static func layoutDirection(for languageCode: String?) -> LayoutDirection {
		guard let languageCode = languageCode else {
			return .leftToRight
		}
		
		switch languageCode {
			case "ar": return .rightToLeft  // Arabic
			case "az": return .rightToLeft  // Azeri
			case "dv": return .rightToLeft  // Maldivian
			case "ff": return .rightToLeft  // Fulah
			case "he": return .rightToLeft  // Hebrew
			case "ku": return .rightToLeft  // Kurdish
			case "fa": return .rightToLeft  // Persian
			case "ur": return .rightToLeft  // Urdu
			default: return .leftToRight
		}
	}
	
	///Returns a layout direction of the current locale
	static var layoutDirection: LayoutDirection {
		switch current.languageCode {
			case "ar": return .rightToLeft  // Arabic
			case "he": return .rightToLeft  // Hebrew
				
				//❕some langs may r2l/l2r layouts
				// depending on script (e.g. arab/latn)
				// should switch over scriptCode to
				// to return proper direction
				// these are kept here to later isolate
				// into specialized locale lib/extentions
				// case "ur": return .rightToLeft // Urdu
				// case "az": return .rightToLeft // Azeri
				// case "ku": return .rightToLeft // Kurdish
				// case "dv": return .rightToLeft // Maldivian
				// case "ff": return .rightToLeft // Fulah
				// case "fa": return .rightToLeft // Persian
			default: return .leftToRight
		}
	}
	
	///Returns a layout direction for the instance of Locale
	var layoutDirection: LayoutDirection {
		return Self.layoutDirection(for: languageCode)
	}
	
	///English name of the locale's languageCode
	var languageName: (inEnglish: String, inNative: String) {
		switch languageCode {
			case "ar": return ("Arabic", "العربية")
			case "en": return ("English", "English")
			case "he": return ("Hebrew", "עברית")
			case "fr": return ("French", "Français")
			case "ru": return ("Russian", "Русский")
			case "es": return ("Spanish", "Español")
			default: return ("Undefined", "Undefined")
				// notaTODO import other languages
				// https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
				
				// notaTODO account for languageCode+scriptCode
				// variations (e.g. transliterated locales)
		}
	}
	
	/// Locale's language name exposed as LocalizedStringKey
	/// The key must exist within Localizable.strings
	var languageNameLocalized: LocalizedStringKey {
		.init(languageName.inEnglish)
	}
}
