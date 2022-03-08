//
//  LanguageListEndpoint.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import Foundation
import Apexy

struct LanguageListEndpoint: JsonEndpoint, URLRequestBuildable {
    typealias Content = LanguageResponseModel
    
    func makeRequest() throws -> URLRequest {
        let url = URL(string: "v3/languages")!
        let queryItem = URLQueryItem(name: "version", value: "2018-05-01")
        return get(url, queryItems: [queryItem])
    }
}
