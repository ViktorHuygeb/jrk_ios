//
//  ProfielViewModel.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 04/01/2025.
//
import Foundation

class ProfielViewModel: ObservableObject {
    @Published var error: (any Error)?
    @Published var hasError: Bool = false
    
    func logout() {
        do {
            guard Keychain.delete("jwtToken") else {
                throw LoginError.keychainError
            }
            
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            UserDefaults.standard.set(false, forKey: "isLeiding")

                      
        } catch {
            hasError = true
            self.error = error
        }
    }
    
    func toLogin() {
        UserDefaults.standard.set(true, forKey: "isLoggingIn")
    }
}
