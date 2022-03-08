//
//  TranslationService.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 14.02.2022.
//

import Foundation

protocol TranslationService: AnyObject {
    @discardableResult
    func translate(
        with request: TranslationRequestModel,
        completion: @escaping (Result<TranslationResponseModel, Error>) -> Void) -> Progress
    
    @discardableResult
    func getLanguageList(
        completion: @escaping (Result<LanguageResponseModel, Error>) -> Void) -> Progress
}

final class MainTranslationService: APIService, TranslationService {
    
    func translate(
        with request: TranslationRequestModel,
        completion: @escaping (Result<TranslationResponseModel, Error>) -> Void) -> Progress {
            
        apiClient.request(TranslationEndpoint(request: request)) { result in
            switch result {
            case .success(let content):
                completion(.success(content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLanguageList(
        completion: @escaping (Result<LanguageResponseModel, Error>) -> Void) -> Progress {
            
        apiClient.request(LanguageListEndpoint()) { result in
            switch result {
            case .success(let content):
                completion(.success(content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
