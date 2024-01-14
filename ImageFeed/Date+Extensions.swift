import Foundation

extension Date {
    var dateString: String { dateTimeDefaultFormatter.string(from: self) }
    
    private var dateTimeDefaultFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
}
