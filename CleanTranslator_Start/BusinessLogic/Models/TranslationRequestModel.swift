//
//  TranslationRequestModel.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import Foundation

struct TranslationRequestModel: Codable {
    let text: [String]
    let modelId: String
}
