//
//  JRKClient.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

// TODO - Make an extension so the JSONDecoder always uses the right date decoding strategy
class JRKClient {
    
    var activiteiten: [Activiteit] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allActiviteiten = try decoder.decode(GenericJSON<Activiteit>.self, from: data)
            return allActiviteiten.items
        }
    }
    
    private lazy var decoder = JSONDecoder()
    
    private let feedURL = URL(string: "https://webservices-jrk.onrender.com/api/activiteiten")!
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared){
        self.downloader = downloader
    }
}
