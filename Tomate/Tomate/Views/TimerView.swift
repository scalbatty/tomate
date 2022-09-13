import SwiftUI
import Combine

struct TimerView: View {
    @State var timer: TomateTimer
    @State var isShowingTimerSelectionModal: Bool = false

    private let formatter: DateComponentsFormatter = .timerFormatter

    var body: some View {
        VStack {
            TimelineView(.periodic(from: .now, by: 1)) { _ in
                ProgressView(value: timer.progress) {
                    if timer.hasStarted {
                        Text(formattedTime!)
                    } else {
                        Button(formattedTime!) {
                            isShowingTimerSelectionModal = true
                        }
                    }
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
        .sheet(isPresented: $isShowingTimerSelectionModal) {
            TimeSelectionView()
        }
    }

    var formattedTime: String? {
        formatter.string(from: timer.timeRemaining)
    }
}

struct TimeSelectionView: View {
    var body: some View {
        Text("Select time here")
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timer: TomateTimer(status: .stopped))
        TimerView(timer: TomateTimer(status: .running(dueDate: Date(timeIntervalSinceNow: 256))))
        TimerView(timer: TomateTimer(status: .paused(timeRemaining: 23 * 60 + 34)))
    }
}
