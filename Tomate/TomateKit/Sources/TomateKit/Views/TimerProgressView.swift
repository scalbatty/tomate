import SwiftUI

struct TimerProgressView: View {
    private static let circleRange: ClosedRange<Double> = 0.15...0.85

    var value: Double?

    var body: some View {
        ZStack {
            Self.makeCircle(Color(white: 0.85))
            Self.makeCircle(
                Gradient(colors: [.orange, .red]),
                value: value ?? 0
            )
        }
        .padding()
    }

    private static func makeCircle<S: ShapeStyle>(
        _ content: S,
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
                    lineWidth: 20,
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
