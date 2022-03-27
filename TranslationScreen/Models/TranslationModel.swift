//
//  TranslationModel.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 23.02.2022.
//

import Foundation

struct TranslationModel: Codable {
    let text: String
    
    init(from model: TranslationAPIModel) {
        text = model.translation
    }
}
