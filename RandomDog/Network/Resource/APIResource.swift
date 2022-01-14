//
//  APIResource.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import Foundation

protocol APIResource {

    associatedtype Response: Codable
    var urlString: String {get}
    var URL: URL? {get}

    var scheme: String {get}
    var method: String {get}
    var parameters: [URLQueryItem] {get}
    var headers: [URLQueryItem] {get}
}

extension APIResource {
    var URL: URL? {
        if !urlString.isEmpty {
            if let components = URLComponents(string: urlString) {
                return components.url
            }
        }
        return nil
    }

    var scheme: String {
        "https"
    }
    var method: String {
        "GET"
    }
    var parameters: [URLQueryItem] {
        return []
    }
    var headers: [URLQueryItem] {
        return []
    }
}
