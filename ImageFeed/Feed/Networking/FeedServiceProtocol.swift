//
//  ProfileServiceProtocol.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

protocol FeedServiceProtocol {
    var networkClient: NetworkClientProtocol { get }

    func fetchFeed()
}
