//
//  Leiding.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 28/12/2024.
//

import Foundation

struct Leiding: Hashable, Encodable, Identifiable {
    var id: Int
    var voornaam: String
    var achternaam: String
    var email: String
    var straat: String
    var huisnummer: String
    var postcode: Int
    var stad: String
    var geboortedatum: Date
}

extension Leiding {
    static var emptyLeiding = Leiding(id: 0, voornaam: "", achternaam: "", email: "", straat: "", huisnummer: "", postcode: 0, stad: "", geboortedatum: Date())
}

extension Leiding {
    static var sampleData: [Leiding] = [
        Leiding(id: 1, voornaam: "Viktor", achternaam: "Huygebaert", email: "viktorhuygebaert04@gmail.com", straat: "Sint-Jozefstraat", huisnummer: "1", postcode: 9880, stad: "Aalter", geboortedatum: GlobalDateFormatter.shared.date(from: "06/05/2004") ?? Date()),
        Leiding(id: 2, voornaam: "Batist", achternaam: "Huygebaert", email: "viktorhuygebaert04@gmail.com", straat: "Sint-Jozefstraat", huisnummer: "1", postcode: 9880, stad: "Aalter", geboortedatum: GlobalDateFormatter.shared.date(from: "01/11/2000") ?? Date())
    ]
}

extension Leiding: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "leidingId"
        case voornaam = "voorNaam"
        case achternaam = "familieNaam"
        case email
        case straat
        case huisnummer
        case postcode
        case stad
        case geboortedatum
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? values.decode(Int.self, forKey: .id)
        let rawVoornaam = try? values.decode(String.self, forKey: .voornaam)
        let rawAchternaam = try? values.decode(String.self, forKey: .achternaam)
        let rawEmail = try? values.decode(String.self, forKey: .email)
        let rawStraat = try? values.decode(String.self, forKey: .straat)
        let rawHuisnummer = try? values.decode(Int.self, forKey: .huisnummer)
        let rawPostcode = try? values.decode(Int.self, forKey: .postcode)
        let rawStad = try? values.decode(String.self, forKey: .stad)
        let rawGeboortedatum = try? values.decode(String.self, forKey: .geboortedatum)
        
        guard let id = rawId,
              let voornaam = rawVoornaam,
              let achternaam = rawAchternaam,
              let email = rawEmail,
              let straat = rawStraat,
              let huisnummer = rawHuisnummer,
              let postcode = rawPostcode,
              let stad = rawStad,
              let geboorteDatum = rawGeboortedatum
        else {
            
            throw APIError.missingData(forType: "leiding")
        }
        
        self.id = id
        self.voornaam = voornaam
        self.achternaam = achternaam
        self.email = email
        self.straat = straat
        self.huisnummer = "\(huisnummer)"
        self.postcode = postcode
        self.stad = stad
        self.geboortedatum = Activiteit.getDate(fromISO: geboorteDatum) ?? GlobalDateFormatter.shared.date(from: "06/05/2004")!
    }
}
