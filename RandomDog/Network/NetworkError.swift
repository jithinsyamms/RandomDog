//
//  NetworkError.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case decodeError
    case unknownError
    case invalidURL
}
