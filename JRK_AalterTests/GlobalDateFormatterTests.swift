//
//  GlobalDateFormatterTests.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation
@testable import JRK_Aalter
import Testing

struct GlobalDateFormatterTests {
    @Test("Check date created from ISO substring") func dateFromJson() throws {
        let expectedDate = Date(timeIntervalSince1970: TimeInterval(1714780800))
        
        let recievedDate = try #require(GlobalDateFormatter.shared.getDate(fromIsoSubstring: "2024-05-04"))
        
        #expect(recievedDate == expectedDate)
    }
}
