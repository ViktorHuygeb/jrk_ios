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
    
    internal init(data: T){
        self.data = data
        self.count = nil
        self.error = nil
    }
    
    internal init(error: APIError){
        self.data = nil
        self.count = nil
        self.error = error
    }
    
    func getData() throws -> T {
        guard let unwrappedData = data else {
            throw APIError.missingData(forType: "")
        }
        return unwrappedData
    }
    
    func itemCount() throws -> Int {
        guard let unwrappedCount = count else {
            throw APIError.missingData(forType: "item count")
        }
        return unwrappedCount
    }
    
    var isSucces: Bool { data != nil }
    
    var hasError: Bool { error != nil }
}
