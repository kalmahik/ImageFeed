import Foundation

extension Date {
    var dateString: String { Date.dateTimeDefaultFormatter.string(from: self) }

    private static let dateTimeDefaultFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
}
