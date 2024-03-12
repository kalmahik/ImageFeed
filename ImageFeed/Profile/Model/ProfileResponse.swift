import Foundation

struct ProfileResponse: Decodable {
    let id: String
    let username: String
    let firstName: String?
    let lastName: String?
    let bio: String?
}
