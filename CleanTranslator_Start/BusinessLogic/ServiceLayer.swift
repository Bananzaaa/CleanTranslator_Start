//
//  ServiceLayer.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 14.02.2022.
//

import Apexy
import Foundation

final class ServiceLayer {
    
    // MARK: - Init
    
    private init() {}
    static let shared = ServiceLayer()
    
    // MARK: - Private properties

    private let creds = TranslatorCredentials()
    private lazy var baseUrl = URL(string: creds.stringURL)!
    private lazy var interceptor = RequestInterceptor(baseURL: baseUrl, apiKey: creds.apiKey)
    
    // MARK: - Public properties
    
    private(set) lazy var apiClient: Client = {
        AlamofireClient(
            requestInterceptor: interceptor,
            configuration: .ephemeral) { [weak self] request, _, data, error in
                self?.debugLogSession(request: request, data: data, responseError: error)
            }
    }()
    
    // MARK: - Services
    
    private(set) lazy var translationService: TranslationService = MainTranslationService(apiClient: apiClient)
    
    // MARK: - Private methods
    
    private func debugLogSession(request: URLRequest?, data: Data?, responseError: Error?) {
        
        // For debug only
        let body = String(data: request?.httpBody ?? Data(), encoding: .utf8)
        Utils.debugLog("\n\n" + "URL: \(String(describing: request?.url?.absoluteString))")
        Utils.debugLog("Method: \(String(describing: request?.method?.rawValue ?? ""))")
        Utils.debugLog("Headers: \(String(describing: request?.headers))")
        Utils.debugLog("Body: \(String(describing: body))")
        let data = String(data: data ?? Data(), encoding: .utf8)
        Utils.debugLog("Response data: \(String(describing: data))")
        Utils.debugLog("Error: \(String(describing: responseError))\n")
    }
}

final class Utils {
    static func debugLog(_ items: String..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        Swift.print(items.map { $0 }.joined(separator: separator), terminator: terminator)
        #endif
    }
}
