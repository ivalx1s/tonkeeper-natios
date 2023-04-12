import SwiftUI

public struct DebugBorderModifier: ViewModifier {
	private var color: Color
	private var enabled: Bool
	private let strokeStyle: StrokeStyle
	
	@Binding private var globalSwitch: Bool
	
	public init(
		color: Color,
		strokeStyle: StrokeStyle = .debugBorderStrokeStyle,
		enabled: Bool,
		globalSwitch: Binding<Bool>
	) {
		self._globalSwitch = globalSwitch
		self.color = color
#if DEBUG
		self.enabled = enabled
#else
		self.enabled = false
#endif
		self.strokeStyle = strokeStyle
	}
	
	
	
	public func body(content: Content) -> some View {
#if DEBUG
		if globalSwitch {
			switch enabled {
				case true:
					content
						.overlay(
							Rectangle()
								.strokeBorder(
									color.opacity(0.7),
									style: strokeStyle
								)
						)
				case false:
					content
			}
		} else {
			content
		}
#else
		content
#endif
	}
}

public extension View {
	/// A simple border that only wraps a view if enabled; useful during layout debugging.
	func debugBorder(
		_ color: Color,
		_ enabledState: DebugBorderModifier.BorderSwitch,
		globalSwitch: Binding<Bool>
	) -> some View {
		self.modifier(
			DebugBorderModifier(color: color,
								enabled: enabledState.asBool,
								globalSwitch: globalSwitch)
		)
	}
}



public extension StrokeStyle {
	static var debugBorderStrokeStyle: StrokeStyle {
		.init(
			lineWidth: 1,
			lineCap: .square,
			lineJoin: .miter,
			dash: [1, 10],
			dashPhase: .random(in: 0...20)
		)
	}
	
}

public extension DebugBorderModifier {
	enum BorderSwitch {
		case enabled
		case disabled
		
		var asBool: Bool {
			switch self {
				case .enabled: return true
				case .disabled: return false
			}
		}
	}
}
