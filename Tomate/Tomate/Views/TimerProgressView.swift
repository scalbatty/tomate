import SwiftUI

struct TimerProgressView: View {
    private static let boundsWhenPositive: ClosedRange<Double> = 0.177...1.0

    var value: Double?

    var sanitizedValue: Double {
        guard let value = value else { return 0 }
        if value <= 0 {
            return 0
        } else {
            return value.mapped(from: 0...1, to: Self.boundsWhenPositive)
        }
    }

    var body: some View {
        ZStack {
            Self.makeCircle(Color(white: 0.85))
            Self.makeCircle(
                Gradient(colors: [.orange, .red]),
                value: sanitizedValue
            )
        }
        .padding()
    }

    private static func makeCircle<S: ShapeStyle>(
        _ content: S,
        value: Double = 1.0
    ) -> some View {
        Circle()
            .trim(from: 0.15, to: 0.85 * value)
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
        TimerProgressView(value: 0.001)
        TimerProgressView(value: 0.3)
        TimerProgressView(value: 1.0)
    }
}
