import Foundation

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String

    init(username: String, name: String, loginName: String, bio: String) {
        self.username = username
        self.name = name
        self.loginName = loginName
        self.bio = bio
    }

    init(_ profileResponse: ProfileResponse) {
        self.username = profileResponse.username
        let lastName = profileResponse.lastName != nil ? " \(String(describing: profileResponse.lastName))" : ""
        self.name = "\(profileResponse.firstName ?? "")\(lastName)"
        self.loginName = "@\(profileResponse.username)"
        self.bio = profileResponse.bio ?? ""
    }
}
