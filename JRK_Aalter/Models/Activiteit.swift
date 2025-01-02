//
//  Activiteit.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//
import Foundation

struct Activiteit: Identifiable {
    var id: Int
    var leidingId: Int
    var activiteitNaam: String
    var datum: Date
    var beschrijving: String
    var prijs: Double
    var moetInschrijven: Bool
}

extension Activiteit {
    static var emptyActiviteit: Activiteit {
        Activiteit(id: 0, leidingId: 1, activiteitNaam: "", datum: Date(), beschrijving: "", prijs: 0, moetInschrijven: false)
    }
}


extension Activiteit{
    static var sampleData: [Activiteit] {
        return [
            Activiteit(id: 1, leidingId: 1, activiteitNaam: "Activiteit 1", datum: GlobalDateFormatter.shared.date(from: "12/01/2025") ?? Date(), beschrijving: "De eerste super leuke activiteit op de website!", prijs: 0.00, moetInschrijven: false),
            Activiteit(id: 2, leidingId: 1, activiteitNaam: "Activiteit 2", datum: GlobalDateFormatter.shared.date(from: "25/01/2025") ?? Date(), beschrijving: "Dit is de 2e activiteit voor dit kalendertje, het is weer een super leuke activiteit vol leuks en andere probeersels. We verwachten jullie om 14.00 uur aan het lokaal, en jullie mogen terug worden opgehaald om 17.00 uur. Inschrijven is verplicht.", prijs: 4.00, moetInschrijven: true),
            Activiteit(id: 3, leidingId: 2, activiteitNaam: "Activiteit 3", datum: GlobalDateFormatter.shared.date(from: "09/02/2025") ?? Date(), beschrijving: "Dit is de 3e activiteit voor dit kalendertje, het is weer een super leuke activiteit vol leuks en andere probeersels. We verwachten jullie om 14.00 uur aan het lokaal, en jullie mogen terug worden opgehaald om 17.00 uur. Inschrijven is verplicht.", prijs: 0.00, moetInschrijven: true)
        ]
    }
}

extension Activiteit: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "activiteitId"
        case leidingId
        case activiteitNaam
        case datum
        case beschrijving
        case prijs
        case moetInschrijven
    }
    
    static func getDate(fromISO dateString: String) -> Date? {
        let indexOfT = dateString.firstIndex(of: "T") ?? dateString.endIndex
        let isolatedDateString = dateString[dateString.startIndex..<indexOfT]
        
        return GlobalDateFormatter.shared.date(fromIsoSubstring: String(isolatedDateString))
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawId = try? values.decode(Int.self, forKey: .id) // try? -> if there is an error thrown, make it nil
        let rawLeidingId = try? values.decode(Int.self, forKey: .leidingId)
        let rawActiviteitNaam = try? values.decode(String.self, forKey: .activiteitNaam)
        let rawDatumString = try? values.decode(String.self, forKey: .datum)
                let rawBeschrijving = try? values.decode(String.self, forKey: .beschrijving)
        let rawPrijs = try? values.decode(Double.self, forKey: .prijs)
        let rawMoetInschrijven = try? values.decode(Bool.self, forKey: .moetInschrijven)
        
        guard let id = rawId,
              let leidingId = rawLeidingId,
              let activiteitNaam = rawActiviteitNaam,
              let datumString = rawDatumString,
              let beschrijving = rawBeschrijving,
              let prijs = rawPrijs,
              let moetInschrijven = rawMoetInschrijven
        else {
            throw ActiviteitError.missingData
        }
        
        self.id = id
        self.leidingId = leidingId
        self.activiteitNaam = activiteitNaam
        self.datum = Activiteit.getDate(fromISO: datumString) ?? Date() // we need to use the static function, because normal static members can't be accessed before initialization of all properties
        self.beschrijving = beschrijving
        self.prijs = prijs
        self.moetInschrijven = moetInschrijven
    }
}
