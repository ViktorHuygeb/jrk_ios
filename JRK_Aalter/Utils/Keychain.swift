//
//  Keychain.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 04/01/2025.
//

import Foundation
import Security

struct Keychain {
    static func set<T: Codable>(_ value: T, forKey key: String) -> Bool {
        do {
            let data = try JSONEncoder().encode(value)
            let query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data
            ]
            
            SecItemDelete(query as CFDictionary) // We're deleting the data already stored here (if there is any)
            
            let status = SecItemAdd(query as CFDictionary, nil)
            return status == errSecSuccess // We check if the status returned by the SecItemAdd is the same status as the errSecSuccess, which tells us that there was no error when adding the item
        } catch {
            return false
        }
    }
    
    static func get<T: Codable>(_ key: String) throws -> T? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
       
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                return value
            } catch {
                throw LoginError.keychainError
            }
        }
        return nil
    }
    
    static func delete(_ key: String) -> Bool {
        let query: [CFString: Any] = [
           kSecClass: kSecClassGenericPassword,
           kSecAttrAccount: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        return status == errSecSuccess
    }
}
