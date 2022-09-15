import Foundation

extension DateComponentsFormatter {
    static var timerFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()

        formatter.allowedUnits = [.minute, .second]
        formatter.allowsFractionalUnits = false
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional

        return formatter
    }
}
