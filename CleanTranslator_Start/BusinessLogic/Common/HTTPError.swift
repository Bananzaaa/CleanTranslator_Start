//
//  HTTPError.swift
//  CleanTranslator
//
//  Created by Stanislav Anatskii on 20.02.2022.
//

import Foundation

public enum HTTPError: Error, Equatable {
    case statusCode(Int)
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        if case .statusCode(let code) = self {
            switch code {
            case 400:
                return "Неверный запрос"
            case 401:
                return "Пользователь не авторизован"
            case 403:
                return "Доступ запрещен"
            case 404:
                return "Языковая модель не найдена"
            case 500:
                return "Внутренняя ошибка сервера"
            default:
                break
            }
        }
        return "Неизвестная ошибка"
    }
}
