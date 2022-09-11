import SwiftUI

struct TimerGaugeStyle: GaugeStyle {
    private static let width: CGFloat = 250
    private static let height: CGFloat = 250

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            TimerGauge(value: configuration.value)
                .frame(width: Self.width,
                       height: Self.width)
            configuration.label
                .font(.timer)
        }
    }
}

extension GaugeStyle where Self == TimerGaugeStyle {
    static var timer: TimerGaugeStyle { TimerGaugeStyle() }
}
