//
//  ActiviteitEditViewModel.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 05/01/2025.
//

import Foundation

@MainActor
class ActiviteitEditViewModel: ObservableObject {
    @Published var activiteit: Activiteit = Activiteit.emptyActiviteit
    @Published var leiding: [Leiding] = []
    @Published var isLoading: Bool = false
    @Published var error: (any Error)?
    @Published var hasError: Bool = false
    
    var client: JRKClient = JRKClient.shared
    
    func fetchLeiding() async {
        isLoading = true
        
        let leidingResource = Resource(url: "leiding", modelType: GenericJSON<Leiding>.self)
        let response: APIResult<GenericJSON<Leiding>> = await client.load(leidingResource)
       
        if response.isSucces {
            leiding = try! response.getData().items
            isLoading = false
        } else {
            hasError = true
            error = response.error
        }
        isLoading = false
    }
    
}
