//
//  APIService.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import Apexy

/// Базовый сервис с API клиентом
class APIService: NSObject {
    
    /// API клиент
    let apiClient: Client
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
}
