//
//  JRKClient.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

// TODO - Make an extension so the JSONDecoder always uses the right date decoding strategy
actor JRKClient {
    var items: [Activiteit] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allActiviteiten = try decoder.decode(GenericJSON<Activiteit>.self, from: data)
            return allActiviteiten.items
       }
    }
    
    func getAllItems<T: Decodable>(from url: String) async -> APIResult<[T]> {
        do {
            let fetchedData = try await downloader.httpData(from: feedURL.appending(component: url))
            let decodedData = try decoder.decode(GenericJSON<T>.self, from: fetchedData)
            return APIResult<[T]>(data: decodedData.items, count: decodedData.count)
        } catch {
            return APIResult<[T]>(error: error as? APIError ?? APIError.unexpectedError(error: error))
        }
    }
    
    private lazy var decoder = JSONDecoder()
    
    private let feedURL = URL(string: "https://webservices-jrk.onrender.com/api/")!
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared){
        self.downloader = downloader
    }
}
