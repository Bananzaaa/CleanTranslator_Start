//
//  Codable+Extensions.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import Foundation

extension JSONEncoder {
    internal static let `default`: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return encoder
    }()
}

extension JSONDecoder {
    internal static let `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        return decoder
    }()
}
