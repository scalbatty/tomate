import SwiftUI

struct TimerProgressViewStyle: ProgressViewStyle {
    private static let width: CGFloat = 250
    private static let height: CGFloat = 250

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            TimerProgressView(value: configuration.fractionCompleted)
                .frame(width: Self.width,
                       height: Self.width)
            configuration.label
                .font(.timer)
        }
    }
}

extension ProgressViewStyle where Self == TimerProgressViewStyle {
    static var timer: TimerProgressViewStyle { TimerProgressViewStyle() }
}
