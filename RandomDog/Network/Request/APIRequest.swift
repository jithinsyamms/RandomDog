//
//  APIRequest.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import Foundation

struct APIRequest<Resource: APIResource>{
    let resource:Resource
    init(resource:Resource){
        self.resource = resource
    }
}

extension APIRequest:NetworkRequest{

    typealias Response = Resource.Response
    func decode(_ data: Data) -> Response? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Model.self, from: data)
    }
    func execute(withCompletion completion: @escaping (Result<Response?, Error>) -> Void) {
        load(resource:resource, withCompletion:completion)
    }
}
