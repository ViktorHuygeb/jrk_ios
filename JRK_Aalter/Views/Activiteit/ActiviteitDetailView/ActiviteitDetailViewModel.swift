//
//  ActiviteitDetailViewModel.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 05/01/2025.
//

import Foundation

@MainActor
class ActiviteitDetailViewModel: ObservableObject {
    @Published var isLeiding = UserDefaults.standard.bool(forKey: "isLeiding")
    @Published var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    @Published var currentActiviteit: Activiteit
    @Published var edititingActiviteit = Activiteit.emptyActiviteit
    @Published var isPresentingEditView = false
    @Published var isSaving: Bool = false
    @Published var error: (any Error)?
    @Published var hasError: Bool = false
    
    let client: JRKClient = JRKClient.shared
    
    init(currentActiviteit: Activiteit){
        self.currentActiviteit = currentActiviteit
    }
    
    func activiteitPrijs() -> String {
        return (currentActiviteit.prijs == 0.00) ? "Gratis" : String(format: "€ %.2f", currentActiviteit.prijs)
    }
    
    func openEditActiviteit() {
        edititingActiviteit = currentActiviteit
        isPresentingEditView = true
    }
    
    func saveActiviteit() async {
        do {
            isSaving = true
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = [.prettyPrinted]
            let body = try encoder.encode(edititingActiviteit)
            print(String(data: body, encoding: .utf8))
            let resource = Resource(url: "activiteiten/\(edititingActiviteit.id)", method: .put(body), modelType: Activiteit.self)
            let response = await client.load(resource)
            
            if response.hasError {
                throw response.error!
            }
            
            currentActiviteit = edititingActiviteit
            isSaving = false
            isPresentingEditView = false
        }catch {
            self.error = error as? APIError ?? APIError.unexpectedError(error: error)
            hasError = true
            isSaving = false
        }
    }
    
    func isActiviteitValid() -> Bool {
        return !edititingActiviteit.activiteitNaam.isEmpty && !edititingActiviteit.beschrijving.isEmpty
    }
}
