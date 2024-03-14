import Foundation

enum ENV: Int {
    case main = 0
    case alternative = 1
}

struct AuthConstants {
    static let accessKeys =  ["jsR4eJSa8sZwpX4IH0jIha-l-I52ziQiCOtVIWENf6k", "DRn3RhRnPFClKYg17IoSY9JStbmF5g-FmJ0hEN-ma88"]
    static let secretKeys =  ["6M0kRYVdL9qadhIOgL5R66WBjrqG72nrJ_hbFuNhStQ", "bgvTrHqb2KMiGgZwqYIwF7zft7Ytwicx-fogIfasD8c"]
    // if you get rate limit error, just change to another ENV here
    static let accessKey = accessKeys[ENV.main.rawValue]
    static let secretKey = secretKeys[ENV.main.rawValue]
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"

    static let authURL = "https://unsplash.com/oauth/authorize"
    static let tokenPath = "/oauth/token"
    static let hostToken = "unsplash.com"
    static let redirectPath = "/oauth/authorize/native"

}

enum AuthKeys: String {
    case clientID = "client_id"
    case clientSecret = "client_secret"
    case redirectUri = "redirect_uri"
    case responseType = "response_type"
    case grantType = "grant_type"
    case scope = "scope"
    case code = "code"
    case authorizationCode = "authorization_code"
    case bearer = "Bearer"
    case authorization = "Authorization"
}
