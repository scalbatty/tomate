import Foundation

public class TimerViewModel: ObservableObject {
    /// A percentile value between 0 and 1
    public typealias TimerProgress = Float

    @Published var timer: TomateTimer

    // TODO: This will not work for mocking and unit tests, need a way to inject current time
    private var now: Date { Date() }

    internal init(timer: TomateTimer) {
        self.timer = timer
    }

    public enum Action: Int, Identifiable {
        case start
        case stop
        case pause
        case resume

        public var id: Int { rawValue }

        public var title: String {
            switch self {
            case .start:
                return "Start"
            case .stop:
                return "Stop"
            case .pause:
                return "Pause"
            case .resume:
                return "Resume"
            }
        }
    }


    /// Remaining time on the timer. Minimum value is 0
    public var timeRemaining: TimeInterval {
        switch timer.status {
        case .stopped:
            return timer.totalTime
        case .running(let dueDate):
            return max(0, dueDate.timeIntervalSince(now))
        case .paused(let timeRemaining):
            return timeRemaining
        }
    }

    public var elapsedTime: TimeInterval { timer.totalTime - timeRemaining }

    /// Percentile progress for the timer (between 0 and 1)
    public var progress: TimerProgress {
        assert(timeRemaining <= timer.totalTime, "Time Remaining should never be over total time")
        return 1 - TimerProgress(timeRemaining / timer.totalTime).clamped(to: 0...1)
    }

    /// True if the time remaining is 0 or less
    public var timeIsUp: Bool {
        timeRemaining <= 0
    }

    public var hasStarted: Bool {
        switch timer.status {
        case .stopped:
            return false
        case .paused, .running:
            return true
        }
    }

    // MARK: Action handling

    /// A list of actions available for the current state of the timer
    public var availableActions: [Action] {
        switch timer.status {
        case .stopped:
            return [.start]
        case .paused:
            return [.stop, .resume]
        case .running:
            if timeIsUp {
                return [.stop]
            } else {
                return [.stop, .pause]
            }
        }
    }

    /// Asks the timer to perform the required action
    public func perform(action: Action) {
        assert(availableActions.contains(action), "Attempting to run an unavailable action")

        switch action {
        case .start:
            start()
        case .stop:
            stop()
        case .pause:
            pause()
        case .resume:
            start()
        }
    }

    func start() {
        var dueDate: Date
        switch timer.status {
        case .stopped:
            dueDate = now.addingTimeInterval(timer.totalTime)
        case .paused(let timeRemaining):
            dueDate = now.addingTimeInterval(timeRemaining)
        case .running(let existingDueDate):
            assert(false)
            // Do nothing
            dueDate = existingDueDate
        }

        timer.status = .running(dueDate: dueDate)
    }

    func stop() {
        timer.status = .stopped
    }

    func pause() {
        timer.status = .paused(timeRemaining: timeRemaining)
    }
}
