//
//  TranslatorCredentials.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 25.02.2022.
//

import Foundation

struct TranslatorCredentials {
    let apiKey: String
    let stringURL: String
    
    init() {
        var credentials: [String: String] = [:]
        if let path = Bundle.main.path(forResource: "creds", ofType: "env") {
            print("path: \(path)")
            do {
                let contents = try String(contentsOfFile: path)
                let lines = contents.components(separatedBy: "\n")
                for line in lines {
                    if !line.isEmpty {
                        let components = line.components(separatedBy: "=")
                        let key = components[0]
                        let value = components[1]
                        credentials[key] = value
                    }
                }
            } catch let error {
                print("error: \(error)")
            }
        }
        apiKey = credentials["LANGUAGE_TRANSLATOR_APIKEY"] ?? ""
        stringURL = credentials["LANGUAGE_TRANSLATOR_URL"] ?? ""
    }
}
