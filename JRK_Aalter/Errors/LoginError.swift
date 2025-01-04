//
//  LoginError.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 04/01/2025.
//

import Foundation

enum LoginError: Error {
    case invalidCredentials
    case keychainError
}

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return NSLocalizedString("Controleer uw inloggegevens", comment: "")
        case .keychainError:
            return NSLocalizedString("Er is een fout opgetreden tijdens het opslaan van uw inloggegevens", comment: "")
        }
    }
}
