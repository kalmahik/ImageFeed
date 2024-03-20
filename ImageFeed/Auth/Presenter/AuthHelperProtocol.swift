import Foundation

protocol AuthHelperProtocol {
    func authRequest() -> URLRequest
    func parseCode(from url: URL) -> String?
}
