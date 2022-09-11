import Foundation

extension Comparable {
    func clamped(to bounds: ClosedRange<Self>) -> Self {
        return min(max(self, bounds.lowerBound), bounds.upperBound)
    }
}

extension BinaryFloatingPoint {
    func mapped(from: ClosedRange<Self>, to: ClosedRange<Self>) -> Self {
        guard from.upperBound - from.lowerBound != 0 else { return self }

        return ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.upperBound - to.lowerBound) + to.lowerBound
    }
}
