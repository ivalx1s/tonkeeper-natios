import TonkUI


public struct PageTabSelectorFrameKey: PreferenceKey {
	public static let defaultValue: [CGRect] = []
	public static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
		value.append(contentsOf: nextValue())
	}
}


public struct PageTabControlBottomPaddingFrameKey: PreferenceKey {
	public static let defaultValue: [CGRect] = []
	public static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
		value.append(contentsOf: nextValue())
	}
}

