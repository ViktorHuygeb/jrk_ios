//
//  ErrorWrapper.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 30/12/2024.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String // this string gets displayed when an error occurs
    
    init (id: UUID = UUID(), error: Error, guidance: String){
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
