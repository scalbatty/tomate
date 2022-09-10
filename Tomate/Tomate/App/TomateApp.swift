import SwiftUI

@main
struct TomateApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView(timer: TomateTimer(status: .stopped))
        }
    }
}
