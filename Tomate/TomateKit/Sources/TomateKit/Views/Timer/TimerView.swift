import SwiftUI
import Combine

public struct TimerView: View {

    @StateObject public var timer: TimerViewModel
    @State public var isShowingTimerSelectionModal: Bool = false

    private let formatter: DateComponentsFormatter = .timerFormatter

    public init(timer: TomateTimer) {
        _timer = StateObject(wrappedValue: TimerViewModel(timer: timer))
    }

    public var body: some View {
        VStack {
            TimelineView(.periodic(from: .now, by: 0.016)) { _ in
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
            TimeSelectionView(
                timer: timer
            )
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
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

