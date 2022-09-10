import Foundation

extension Comparable {
    func clamped(to bounds: ClosedRange<Self>) -> Self {
        return min(max(self, bounds.lowerBound), bounds.upperBound)
    }
}
