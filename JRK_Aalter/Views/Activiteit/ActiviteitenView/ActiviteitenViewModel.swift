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
    @Published var activiteitenCount: Int = 0
    @Published var isLoading = false
    @Published var isPresentingNewActiviteitView = false
    @Published var error: APIError?
    @Published var hasError = false
    
    let client: JRKClient
    
    init(client: JRKClient = JRKClient()) {
        self.client = client
        UserDefaults.standard.set(Date.distantFuture.timeIntervalSince1970, forKey: "lastUpdated")
    }
    
    func fetchActiviteiten() async {
        isLoading = true
        let response: APIResult<[Activiteit]> = await client.getAllItems(from: "activiteiten")
        if (response.isSucces) {
            activiteiten = try! response.items()
            activiteitenCount = try! response.itemCount()
            UserDefaults.standard.set(Date.now.timeIntervalSince1970, forKey: "lastUpdated")
        } else {
            hasError = true
            error = response.error
        }
        isLoading = false
    }
    
    func openAddSheet() {
        isPresentingNewActiviteitView = true
    }
    
    func deleteActiviteiten(indexes: IndexSet){
        for index in indexes {
            activiteiten.remove(at: index)
        }
    }
    
    func saveActiviteit(){
        let haha = 1 + 1
    }
}
