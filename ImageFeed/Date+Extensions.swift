import Foundation

private let dateTimeDefaultFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    return dateFormatter
}()

extension Date {
    var dateString: String { dateTimeDefaultFormatter.string(from: self) }
}
