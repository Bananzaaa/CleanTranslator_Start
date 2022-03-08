//
//  ResponseValidator.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import Foundation

internal enum ResponseValidator {
    
    /// Error response validation.
    ///
    /// - Parameters:
    ///   - response: The metadata associated with the response.
    ///   - body: The response body.
    /// - Throws: `APIError`.
    internal static func validate(
        _ response: URLResponse?,
        with body: Data?
    ) throws {
        try validateAPIResponse(response, with: body)
        try validateHTTPstatus(response)
    }
    
    // MARK: - Private methods
    
    private static func validateAPIResponse(
        _ response: URLResponse?,
        with body: Data?) throws {}
    
    private static func validateHTTPstatus(_ response: URLResponse?) throws {
        guard
            let httpResponse = response as? HTTPURLResponse,
            !(200..<300).contains(httpResponse.statusCode)
        else {
            return
        }
        
        throw HTTPError.statusCode(httpResponse.statusCode)
    }
}
