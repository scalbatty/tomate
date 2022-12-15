import Foundation

public struct TomateTimer {
    public enum Status {
        case stopped // Initial state, waiting for start
        case running(dueDate: Date) // Running, time will be up at dueDate
        case paused(timeRemaining: TimeInterval) // Paused, waiting to continue with remaining time (is this even useful?)
    }

    public var status: Status
    public var totalTime: TimeInterval

    public init(totalTime: TimeInterval = 25 * 60, status: TomateTimer.Status) {
        self.totalTime = totalTime
        self.status = status
    }
}
