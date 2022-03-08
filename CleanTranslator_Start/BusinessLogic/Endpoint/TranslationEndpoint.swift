//
//  TranslationEndpoint.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import Apexy

struct TranslationEndpoint: JsonEndpoint, URLRequestBuildable {
    
    typealias Content = TranslationResponseModel
    
    private let translationRequest: TranslationRequestModel
    
    init(request: TranslationRequestModel) {
        translationRequest = request
    }
    
    func makeRequest() throws -> URLRequest {
        let url = URL(string: "v3/translate?version=2018-05-01")!
        return post(url, body: .json(try JSONEncoder.default.encode(translationRequest)))
    }
}
