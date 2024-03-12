import Foundation

// MARK: - LikeResponse
struct LikeResponse: Decodable {
    let photo: PhotoResponse
    let user: User
}
