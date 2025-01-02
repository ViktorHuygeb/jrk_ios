//
//  APIResource.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation


class APIResult<T: Decodable>{
    private var data: T?
    private var count: Int?
    var error: APIError?
    
    internal init(data: T, count: Int){
        self.data = data
        self.count = count
        self.error = nil
    }
    
    internal init(error: APIError){
        self.data = nil
        self.count = nil
        self.error = error
    }
    
    func items() throws -> T{
        guard let unwrappedData = data else {
            throw APIError.missingData
        }
        return unwrappedData
    }
    
    func itemCount() throws -> Int {
        guard let unwrappedCount = count else {
            throw APIError.missingData
        }
        return unwrappedCount
    }
    
    var isSucces: Bool { data != nil }
    
    var hasError: Bool { error != nil }
}
