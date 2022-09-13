import SwiftUI

struct TimerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
                .font(.actionButton)
                .foregroundColor(.white)
                .padding(EdgeInsets(
                    top: 5,
                    leading: 10,
                    bottom: 5,
                    trailing: 10
                ))
                .background {
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .fill(.tint)
                }
                .scaleEffect(
                    configuration.isPressed ? 0.9 : 1.0
                )
        }
    }
}

extension ButtonStyle where Self == TimerButtonStyle {
    static var timerAction: TimerButtonStyle { TimerButtonStyle() }
}
