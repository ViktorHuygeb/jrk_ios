//
//  ActiviteitDecoderTests.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//
import Testing
import Foundation
@testable import JRK_Aalter

struct ActiviteitDecoderTests {
    let decoder = JSONDecoder()
    
    @Test("Checks id and datum of one decoded activiteit") func ActiviteitDecoderDecodesOneActiviteit() throws {
        let activiteit = try decoder.decode(Activiteit.self, from: testActiviteit_1)
        #expect(activiteit.id == 1)
        
        let expectedDate = Date(timeIntervalSince1970: TimeInterval(1714780800))
        #expect(activiteit.datum == expectedDate)
    }
    
    @Test("Checks decoding of array of activiteiten") func ActiviteitDecoderDecodesArrayOfActiviteiten() throws {
        let decodedActiviteiten = try decoder.decode(GenericJSON<Activiteit>.self, from: testActiviteitenData)
        
        #expect(decodedActiviteiten.count == 4)
        #expect(decodedActiviteiten.items[3].id == 4)
        
        let expectedDate = Date(timeIntervalSince1970: 1730419200)
        #expect(decodedActiviteiten.items[3].datum == expectedDate)
    }
}
