//
//  ActiviteitenJSON.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

struct GenericJSON<Element: Decodable>: Decodable {
    private enum RootCodingKeys: String, CodingKey {
        case items
        case count
    }
    
    private(set) var items: [Element] = []
    private(set) var count: Int = 0
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var itemsContainer = try rootContainer.nestedUnkeyedContainer(forKey: RootCodingKeys.items)
        
        while !itemsContainer.isAtEnd {
            if let item = try? itemsContainer.decode(Element.self) {
                items.append(item)
            }
        }
        
        count = try rootContainer.decode(Int.self, forKey: RootCodingKeys.count)
    }
}
