//
//  JRK_IOSApp.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//

import SwiftUI

@main
struct JRK_Aalter: App {
    @StateObject private var store = ActiviteitStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ActiviteitenView(activiteiten: $store.activiteiten){
                Task {
                    do {
                        try await store.save(activiteiten: store.activiteiten)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Probeer later opnieuw.")
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "JRK Aalter laadt fake data in en gaat verder.")
                    }
                }
                .sheet(item: $errorWrapper){
                    store.activiteiten = Activiteit.sampleData
                } content: { wrapper in
                    ErrorView(errorWrapper: wrapper)
                    
                }
        }
    }
}
