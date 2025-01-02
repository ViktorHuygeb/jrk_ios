//
//  JRKError.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

enum APIError: Error {
    case networkError
    case missingData
    case unexpectedError(error: Error)
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("Er is een fout opgetreden tijdens het ophalen van data over het netwerk.", comment: "")
        case .missingData:
            return NSLocalizedString("Er is geen data beschikbaar.", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Er is een onverwatche fout opgetreden. \(error.localizedDescription)", comment:"")
        }
    }
}
