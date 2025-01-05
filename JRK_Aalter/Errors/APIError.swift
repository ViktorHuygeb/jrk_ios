//
//  JRKError.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

enum APIError: Error {
    case badRequest(message: String)
    case networkError
    case missingData(forType: String)
    case notFound(message: String)
    case unauthorized(message: String)
    case unexpectedError(error: Error)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest(let message):
            return NSLocalizedString( message, comment: "")
        case .networkError:
            return NSLocalizedString("Er is een fout opgetreden tijdens het ophalen van data over het netwerk.", comment: "")
        case .missingData(let forType):
            return NSLocalizedString("Er is geen data gevonden voor \(forType)", comment: "")
        case .notFound(let message):
            return NSLocalizedString(message, comment: "")
        case .unauthorized(let message):
            return NSLocalizedString(message, comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Er is een onverwachte fout opgetreden. \(error.localizedDescription)", comment:"")
        }
    }
}
