//
//  TranslationResponseModel.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import Foundation

struct TranslationResponseModel: Codable {
    let translations: [TranslationAPIModel]
    let wordCount: Int
    let characterCount: Int
}

struct TranslationAPIModel: Codable {
    let translation: String
}
