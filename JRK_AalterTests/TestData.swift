//
//  TestData.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

let testActiviteit_1: Data = """
{
    "activiteitId": 1,
    "leidingId": 1,
    "activiteitNaam": "Leuke activiteit",
    "datum": "2024-05-04T00:00:00.000Z",
    "beschrijving": "De eerste super leuke activiteit op de website !",
    "prijs": 0.0,
    "moetInschrijven": false
}
""".data(using: .utf8)!

let testActiviteitenData: Data = """
{
    "items":[
        {
            "activiteitId": 1,
            "leidingId": 1,
            "activiteitNaam": "Leuke activiteit",
            "datum": "2024-05-04T00:00:00.000Z",
            "beschrijving": "De eerste super leuke activiteit op de app!",
            "prijs": 0.0,
            "moetInschrijven": false
        },
        {
            "activiteitId": 2,
            "leidingId": 2,
            "activiteitNaam": "Test activiteit 2",
            "datum": "2024-05-06T00:00:00.000Z",
            "beschrijving": "De tweede super test activiteit!",
            "prijs": 3.0,
            "moetInschrijven": true
        },
        {
            "activiteitId": 3,
            "leidingId": 1,
            "activiteitNaam": "Test activiteit 3",
            "datum": "2024-05-17T00:00:00.000Z",
            "beschrijving": "Dit is de derde tester van de applicatie",
            "prijs": 0.0,
            "moetInschrijven": true
        },
        {
            "activiteitId": 4,
            "leidingId": 2,
            "activiteitNaam": "Test activiteit 4",
            "datum": "2024-11-01T00:00:00.000Z",
            "beschrijving": "De laatste test op voor de Swift test",
            "prijs": 10.0,
            "moetInschrijven": false
        },
    ],
    "count":4
}
""".data(using: .utf8)!
