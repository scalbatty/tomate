import SwiftUI
import TomateKit

@main
struct TomateApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView(timer: TomateTimer(status: .stopped)).tint(.orange)
        }
    }
}
