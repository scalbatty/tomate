import SwiftUI

struct TimerTemplate: Equatable, Identifiable {
    var id: Int
    var title: String
    var minutes: Int
    var color: Color
}

struct TimeSelectionView: View {

    @ObservedObject var timer: TimerViewModel
    @Environment(\.dismiss) var dismiss

    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()


    private let templates: [TimerTemplate] = [
        TimerTemplate(id: 0, title: "Focus", minutes: 25, color: .blue),
        TimerTemplate(id: 1, title: "Short break", minutes: 5, color: .yellow),
        TimerTemplate(id: 2, title: "Long break", minutes: 30, color: .orange)
    ]

    var body: some View {
        VStack {
            ForEach(templates) { template in
                let components = DateComponents(minute: template.minutes)
                Button {
                    self.timer.timer = TomateTimer(
                        totalTime: TimeInterval(template.minutes * 60),
                        status: .stopped
                    )
                    dismiss()
                } label: {
                    HStack {
                        Text(template.title)
                            .font(.title)
                        Spacer()
                        Text(formatter.string(from: components)!)
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(template.color.gradient)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

struct TimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectionView(timer: TimerViewModel(timer: .init(status: .stopped)))
    }
}

