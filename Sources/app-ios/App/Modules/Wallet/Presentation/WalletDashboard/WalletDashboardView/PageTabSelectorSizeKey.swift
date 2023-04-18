import TonkUI

public struct PageTabSelectorSizeKey: PreferenceKey {
	public static let defaultValue: [CGSize] = []
	public static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
		value.append(contentsOf: nextValue())
	}
}

public struct PageTabSelectorFrameKey: PreferenceKey {
	public static let defaultValue: [CGRect] = []
	public static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
		value.append(contentsOf: nextValue())
	}
}
