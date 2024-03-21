import Foundation

struct UserResponse: Decodable {
    let profileImage: ProfileImage
}

// MARK: - ProfileImage
struct ProfileImage: Decodable {
    let small: String
    let medium: String
    let large: String
}
