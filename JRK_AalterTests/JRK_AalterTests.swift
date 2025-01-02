//
//  JRK_IOSTests.swift
//  JRK_IOSTests
//
//  Created by Viktor Huygebaert on 27/12/2024.
//

import Testing
import Foundation

@testable import JRK_Aalter

struct JRK_AalterTests {
    
    @Test func testActiviteitDecoderDecodesActiviteit() throws {
        let decoder = JSONDecoder()
        let activiteit = try decoder.decode(Activiteit.self, from: testFeature_Activiteit)
        #expect(activiteit.id == 1)
    }
    
    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
