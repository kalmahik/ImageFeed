import Foundation

struct Logger {
    static func networkLog(message: String, urlRequest: URLRequest? = nil) {
        NSLog(
            "[imageFeed][fetch]" +
            "[\(urlRequest?.httpMethod ?? HttpMethods.get.rawValue)]" +
            "[\(urlRequest?.url ?? NetworkConstants.defaultBaseURL)]:" +
            "[\(message)]"
        )
    }
}
