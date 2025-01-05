//
//  LoginResponse.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 04/01/2025.
//

struct LoginResponse: Codable {
    let token: String
    var roles = [Rol]()
}
