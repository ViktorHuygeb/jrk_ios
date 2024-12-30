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
    var body: some Scene {
        WindowGroup {
            ActiviteitenView(activiteiten: $store.activiteiten){
                Task {
                    do {
                        try await store.save(activiteiten: store.activiteiten)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
