//
//  Activiteit.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//
import Foundation

struct Activiteit {
    var id: Int
    var leidingId: Int
    var activiteitNaam: String
    var datum: Date
    var beschrijving: String
    var prijs: Double
    var moetInschrijven: Bool
}


extension Activiteit{
    static var sampleData: [Activiteit] {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return [
            Activiteit(id: 1, leidingId: 1, activiteitNaam: "Activiteit 1", datum: formatter.date(from: "12/01/2025") ?? Date(), beschrijving: "De eerste super leuke activiteit op de website!", prijs: 0.00, moetInschrijven: false),
            Activiteit(id: 2, leidingId: 2, activiteitNaam: "Activiteit 2", datum: formatter.date(from: "25/01/2025") ?? Date(), beschrijving: "Dit is de 2e activiteit voor dit kalendertje, het is weer een super leuke activiteit vol leuks en andere probeersels. We verwachten jullie om 14.00 uur aan het lokaal, en jullie mogen terug worden opgehaald om 17.00 uur. Inschrijven is verplicht.", prijs: 4.00, moetInschrijven: true),
            Activiteit(id: 3, leidingId: 1, activiteitNaam: "Activiteit 3", datum: formatter.date(from: "09/02/2025") ?? Date(), beschrijving: "Dit is de 3e activiteit voor dit kalendertje, het is weer een super leuke activiteit vol leuks en andere probeersels. We verwachten jullie om 14.00 uur aan het lokaal, en jullie mogen terug worden opgehaald om 17.00 uur. Inschrijven is verplicht.", prijs: 0.00, moetInschrijven: true)
        ]
    }
}
