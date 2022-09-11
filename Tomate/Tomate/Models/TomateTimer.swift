import Foundation

struct TomateTimer {
    /// A percentile value between 0 and 1
    typealias Progress = Float

    private static let defaultTotalTime: TimeInterval = 25 * 60

    enum Status {
        case stopped // Initial state, waiting for start
        case running(dueDate: Date) // Running, time will be up at dueDate
        case paused(timeRemaining: TimeInterval) // Paused, waiting to continue with remaining time (is this even useful?)
    }

    enum Action: Int, Identifiable {
        case start
        case stop
        case pause
        case resume

        var id: Int { rawValue }

        var title: String {
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

    var status: Status
    let totalTime: TimeInterval = defaultTotalTime

    // TODO: This will not work for mocking and unit tests, need a way to inject current time
    private var now: Date { Date.now }

    /// Remaining time on the timer. Minimum value is 0
    var timeRemaining: TimeInterval {
        switch status {
        case .stopped:
            return totalTime
        case .running(let dueDate):
            return max(0, dueDate.timeIntervalSince(now))
        case .paused(let timeRemaining):
            return timeRemaining
        }
    }

    var elapsedTime: TimeInterval { totalTime - timeRemaining }

    /// Percentile progress for the timer (between 0 and 1)
    var progress: Progress {
        assert(timeRemaining <= totalTime, "Time Remaining should never be over total time")
        return 1 - Progress(timeRemaining / totalTime).clamped(to: 0...1)
    }

    /// True if the time remaining is 0 or less
    var timeIsUp: Bool {
        timeRemaining <= 0
    }

    // MARK: Action handling

    /// A list of actions available for the current state of the timer
    var availableActions: [Action] {
        switch status {
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
    mutating func perform(action: Action) {
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

    mutating func start() {
        var dueDate: Date
        switch status {
        case .stopped:
            dueDate = now.addingTimeInterval(totalTime)
        case .paused(let timeRemaining):
            dueDate = now.addingTimeInterval(timeRemaining)
        case .running(let existingDueDate):
            assert(false)
            // Do nothing
            dueDate = existingDueDate
        }

        status = .running(dueDate: dueDate)
    }

    mutating func stop() {
        status = .stopped
    }

    mutating func pause() {
        status = .paused(timeRemaining: timeRemaining)
    }
}
