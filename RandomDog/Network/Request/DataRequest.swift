//
//  ImageRequest.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import Foundation

struct DataRequest<Resource: APIResource> {
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}

extension DataRequest: NetworkRequest {

    func decode(_ data: Data) -> Data? {
        return data
    }

    func execute(withCompletion completion: @escaping (Result<Data?, Error>) -> Void) {
        load(resource: resource, withCompletion: completion)
    }

    typealias Response = Data

}
