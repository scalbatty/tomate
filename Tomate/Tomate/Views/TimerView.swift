import SwiftUI
import Combine

struct TimerView: View {
    @State var timer: TomateTimer

    private let formatter: DateComponentsFormatter = .timerFormatter

    var body: some View {
        VStack {
            Text(formattedTime!).font(.system(.title))
            ProgressView(value: timer.progress)
            HStack {
                ForEach(timer.availableActions) { action in
                    Button(action.title) {
                        timer.perform(action: action)
                    }
                    .buttonStyle(.borderedProminent)
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
        TimerView(timer: TomateTimer(status: .paused(timeRemaining: 110)))
    }
}
