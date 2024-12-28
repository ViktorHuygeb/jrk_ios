//
//  Leiding.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 28/12/2024.
//

import Foundation

struct Leiding: Hashable {
    var leidingId: Int
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
    static var emptyLeiding = Leiding(leidingId: 0, voornaam: "", achternaam: "", email: "", straat: "", huisnummer: "", postcode: 0, stad: "", geboortedatum: Date())
}

extension Leiding {
    static var sampleData: [Leiding] = [
        Leiding(leidingId: 1, voornaam: "Viktor", achternaam: "Huygebaert", email: "viktorhuygebaert04@gmail.com", straat: "Sint-Jozefstraat", huisnummer: "1", postcode: 9880, stad: "Aalter", geboortedatum: GlobalDateFormatter.shared.date(from: "06/05/2004") ?? Date()),
        Leiding(leidingId: 2, voornaam: "Batist", achternaam: "Huygebaert", email: "viktorhuygebaert04@gmail.com", straat: "Sint-Jozefstraat", huisnummer: "1", postcode: 9880, stad: "Aalter", geboortedatum: GlobalDateFormatter.shared.date(from: "01/11/2000") ?? Date())
    ]
}
