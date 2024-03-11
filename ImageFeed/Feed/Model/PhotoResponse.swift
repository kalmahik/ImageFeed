import Foundation

// MARK: - PhotoResponse
struct PhotoResponse: Decodable {
    let id: String
    let createdAt, updatedAt: Date?
    let width, height: Int
    let color, blurHash: String?
    let likes: Int
    let likedByUser: Bool
    let description: String?
    let user: User
    let urls: Urls
    let links: PhotoResponseLinks
}

// MARK: - PhotoResponseLinks
struct PhotoResponseLinks: Decodable {
    let html, download, downloadLocation: String?
}

// MARK: - Urls
struct Urls: Decodable {
    let raw, full, regular, small, thumb: String
}

// MARK: - User
struct User: Decodable {
    let id, username, name: String
    let portfolioURL, bio, location: String?
    let totalLikes, totalPhotos, totalCollections: Int
    let instagramUsername, twitterUsername: String?
    let profileImage: ProfileImage
    let links: UserLinks
}

// MARK: - UserLinks
struct UserLinks: Decodable {
    let html, photos, likes, portfolio: String?
}
