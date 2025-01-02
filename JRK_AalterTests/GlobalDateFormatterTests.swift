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
    @Suite("Date from strings")
    struct GlobalDateFormatterDateTests {
        let expectedDate = Date(timeIntervalSince1970: TimeInterval(1714780800))
        
        @Test("Check date created from ISO substring") func dateFromJson() throws {
            let recievedDate = try #require(GlobalDateFormatter.shared.getDate(fromIsoSubstring: "2024-05-04"))
            
            #expect(recievedDate == expectedDate)
        }
        
        @Test("Check date from dd/MM/yyyy format") func dateFromDayMonthYear() throws {
            let recievedDate = try #require(GlobalDateFormatter.shared.getDate(from: "04/05/2024"))
            
            #expect(recievedDate == expectedDate)
        }
        
    }
    
    @Suite("Strings from date")
    struct GlobalDateFormatterStringTests {
        let toFormatDate = Date(timeIntervalSince1970: TimeInterval(1714780800))
        
        @Test("Checks ISO format of datestring") func dateToIsoString() throws {
            let formattedDate = try #require(GlobalDateFormatter.shared.getDateISOString(from: toFormatDate))
            
            #expect(formattedDate == "2024-05-04T00:00:00Z")
        }
        
        @Test("Checks dd/MM/yyyy string format") func dateToDayMonthYearString() throws {
            let formattedDate = try #require(GlobalDateFormatter.shared.getDateString(from: toFormatDate))
            
            #expect(formattedDate == "04/05/2024")
        }
    }
}
