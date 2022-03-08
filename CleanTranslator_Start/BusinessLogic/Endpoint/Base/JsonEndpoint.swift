//
//  JsonEndpoint.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import Apexy

/// JSON Body Request Enpoint.

protocol JsonEndpoint: Endpoint, URLRequestBuildable where Content: Decodable {}

extension JsonEndpoint {
        
    public func content(
        from response: URLResponse?,
        with body: Data
    ) throws -> Content {
        let content = try JSONDecoder.default.decode(Content.self, from: body)
        return content
    }
    
    public func validate(_ request: URLRequest?, response: HTTPURLResponse, data: Data?) throws {
        /// API and HTTP errors check
        try ResponseValidator.validate(response, with: data)
    }
}
