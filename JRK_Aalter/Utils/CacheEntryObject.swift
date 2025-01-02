//
//  Untitled.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry){
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<[Activiteit], Error>)
    case ready([Activiteit])
}
