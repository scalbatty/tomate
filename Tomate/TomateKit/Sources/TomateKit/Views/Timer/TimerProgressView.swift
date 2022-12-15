import SwiftUI

struct TimerProgressView: View {
    private static let circleRange: ClosedRange<Double> = 0.15...0.85

    var value: Double?
    var thickness: CGFloat = 30
    var shadowRadius: CGFloat = 5

    @Environment(\.colorScheme) var colorScheme

    private static let backgroundLight = Color(white: 0.85)
    private static let backgroundDark = Color(white: 0.25)

    var body: some View {
        ZStack {
            Self.makeCircle(
                colorScheme == .dark ? Self.backgroundDark : Self.backgroundLight,
                lineWidth: self.thickness
            )
            Self.makeCircle(
                Color.accentColor.gradient,
                lineWidth: self.thickness,
                value: value ?? 0
            )
        }
        .padding(thickness / 2)
    }

    private static func makeCircle<S: ShapeStyle>(
        _ content: S,
        lineWidth: CGFloat,
        value: Double = 1.0
    ) -> some View {
        Circle()
            .trim(from: Self.circleRange.lowerBound,
                  to: value.mapped(from: 0...1,
                                   to: Self.circleRange))
            .rotation(.degrees(90))
            .stroke(
                content,
                style: StrokeStyle(
                    lineWidth: lineWidth,
                    lineCap: .round
                )
            )
    }
}

struct TimerProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TimerProgressView(value: 0)
        TimerProgressView(value: 0.000001)
        TimerProgressView(value: 0.3)
        TimerProgressView(value: 1.0)
    }
}
