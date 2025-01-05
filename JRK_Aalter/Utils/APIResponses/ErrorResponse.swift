//
//  ErrorResponse.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 04/01/2025.
//

struct ErrorResponse: Codable {
    let code: String
    let message: String
    let details: ErrorDetails
}

struct ErrorDetails: Codable {
    let body: ErrorBody
}

struct ErrorBody: Codable {
    let leidingId: [ValidationError]?
    let datum: [ValidationError]?
    let naam: [ValidationError]?
    let beschrijvingen: [ValidationError]?
    let prijs: [ValidationError]?
}

struct ValidationError: Codable {
    let type: String
    let message: String
}
