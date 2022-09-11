import SwiftUI

struct TimerGauge: View {
    private static let boundsWhenPositive: ClosedRange<Double> = 0.177...1.0

    var value: Double

    var sanitizedValue: Double {
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

struct TimerGauge_Previews: PreviewProvider {
    static var previews: some View {
        TimerGauge(value: 0)
        TimerGauge(value: 0.001)
        TimerGauge(value: 0.3)
        TimerGauge(value: 1.0)
    }
}
