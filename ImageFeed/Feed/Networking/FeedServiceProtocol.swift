import Foundation

protocol FeedServiceProtocol {
    var networkClient: NetworkClientProtocol { get }

    func fetchFeed()
}
