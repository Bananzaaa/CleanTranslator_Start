//
//  RequestInterceptor.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 14.02.2022.
//

import Alamofire
import Apexy
import Foundation

final class RequestInterceptor: Alamofire.RequestInterceptor {
    
    // MARK: - Private properties
    
    private let baseURL: URL
    private let apiKey: String?
    
    private var credentials: String {
        let username = "apikey"
        let loginString = "\(username):\(apiKey ?? "")"
        let loginData = loginString.data(using: String.Encoding.utf8)
        
        return loginData?.base64EncodedString() ?? ""
    }
    
    // MARK: - Init
    
    init(baseURL: URL, apiKey: String?) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    // MARK: - Public methods
    
    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void) {
            
        guard let url = urlRequest.url else { return }
        
        var request = urlRequest
        request.url = appendingBaseURL(to: url)
        request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
        
        completion(.success(request))
    }
    
    public func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void) {
            
        completion(.doNotRetry)
    }
    
    // MARK: - Private methods
    
    private func appendingBaseURL(to url: URL) -> URL {
        URL(string: url.absoluteString, relativeTo: baseURL)!
    }
}
