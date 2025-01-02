//
//  ActiviteitenViewModel.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import Foundation

@MainActor // MainActor makes sure all methods get executed on the main thread.
class ActiviteitenViewModel: ObservableObject {
    @Published var activiteiten: [Activiteit] = []
    @Published var isPresentingNewActiviteitView = false
    @Published var error: JRKError?
    @Published var hasError = false
    
    let client: JRKClient
    
    init(client: JRKClient = JRKClient()) {
        self.client = client
    }
    
    func fetchActiviteiten() async {
        do {
            let fetchedActiviteiten = try await client.activiteiten
            self.activiteiten = fetchedActiviteiten
        } catch {
            self.error = error as? JRKError ?? .unexpectedError(error: error)
            self.hasError = true
        }
    }
    
    func openAddSheet() {
        isPresentingNewActiviteitView = true
    }
    
    func saveActiviteit(){
        fatalError("Not implemented")
    }
}
