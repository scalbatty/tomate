import SwiftUI
import Combine

struct TimerView: View {
    @State var timer: TomateTimer

    private let formatter: DateComponentsFormatter = .timerFormatter

    var body: some View {
        VStack {
            TimelineView(.periodic(from: .now, by: 1)) { _ in
                ProgressView(value: timer.progress) {
                    Text(formattedTime!)
                }
                .progressViewStyle(.timer)
            }
            HStack {
                ForEach(timer.availableActions) { action in
                    Button(action.title) {
                        timer.perform(action: action)
                    }
                    .buttonStyle(.timerAction)
                }
            }
        }
        .padding()
    }

    var formattedTime: String? {
        formatter.string(from: timer.timeRemaining)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timer: TomateTimer(status: .stopped))
        TimerView(timer: TomateTimer(status: .running(dueDate: Date(timeIntervalSinceNow: 256))))
        TimerView(timer: TomateTimer(status: .paused(timeRemaining: 23 * 60 + 34)))
    }
}
