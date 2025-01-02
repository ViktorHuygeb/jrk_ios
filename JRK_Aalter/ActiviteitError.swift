//
//  ActiviteitError.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

enum ActiviteitError: Error {
    case missingData
}

extension ActiviteitError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Er is een activiteit gevonden met te weinig data. Deze verwijderen we",
                comment: ""
            )
        }
    }
}
