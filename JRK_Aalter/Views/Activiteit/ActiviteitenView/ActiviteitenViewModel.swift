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
    
    let client: JRKClient = JRKClient.shared
    
    init() {
        UserDefaults.standard.set(Date.distantFuture.timeIntervalSince1970, forKey: "lastUpdated")
    }
    
    func fetchActiviteiten() async {
        isLoading = true
        let activiteitenResource = Resource(url: "activiteiten", modelType: GenericJSON<Activiteit>.self)
        let response: APIResult<GenericJSON<Activiteit>> = await client.load(activiteitenResource)
        if (response.isSucces) {
            activiteiten = try! response.getData().items
            activiteitenCount = try! response.getData().count
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
    
    func deleteActiviteiten(indexes: IndexSet) async{
        for index in indexes {
            let indexOfItemToDelete = activiteiten[index].id
            let deleteResource = Resource(url: "activiteiten/\(indexOfItemToDelete)", method: .delete, modelType: Int.self)
            let response: APIResult<Int> = await client.load(deleteResource)
            if (response.isSucces) {
                activiteiten.removeAll(where: { $0.id == indexOfItemToDelete })
               await fetchActiviteiten()
            } else {
                switch response.error {
                case .unauthorized(_):
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    UserDefaults.standard.set(false, forKey: "isLeiding")
                default:
                    self.hasError = true
                    error = response.error
                }
            }
        }
    }
    
    func saveActiviteit(){
        let haha = 1 + 1
    }
}
