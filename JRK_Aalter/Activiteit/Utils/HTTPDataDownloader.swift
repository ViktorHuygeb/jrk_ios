//
//  HTTPDataDownloader.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//
import Foundation

let validStatus = 200...299

protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw JRKError.networkError
        }
        
        return data
    }
}
