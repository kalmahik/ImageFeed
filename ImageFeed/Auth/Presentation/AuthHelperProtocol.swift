//
//  AuthHelperProtocol.swift
//  ImageFeed
//
//  Created by kalmahik on 19.03.2024.
//

import Foundation

protocol AuthHelperProtocol {
    func authRequest() -> URLRequest
    func parseCode(from url: URL) -> String?
}
