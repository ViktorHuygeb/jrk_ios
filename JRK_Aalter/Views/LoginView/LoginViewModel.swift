//
//  LoginViewModel.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 04/01/2025.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: (any Error)?
    @Published var hasError: Bool = false
    @Published var isAuthenticating: Bool = false
    
    let client: JRKClient = JRKClient.shared
    
    func login() async {
        do {
            isAuthenticating = true
            let params = ["email": email, "password": password]
            let body = try JSONEncoder().encode(params)
            
            let resource = Resource(url: "users/login", method: .post(body), modelType: LoginResponse.self)
            let response = await client.load(resource)
            
            if response.hasError {
                throw response.error!
            }
            
            let token = try response.getData().token
            guard Keychain.set(token, forKey: "jwtToken") else {
                throw LoginError.keychainError
            }
            
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.set(try response.getData().roles.contains(.Leiding), forKey: "isLeiding")
            isAuthenticating = false
        }
        catch {
            isAuthenticating = false
            self.error = error as? APIError ?? APIError.unexpectedError(error: error)
            hasError = true
        }
    }
}
