//
//  JRK_IOSApp.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//

import SwiftUI

@main
struct JRK_Aalter: App {
    @AppStorage("isLoggingIn") var isLoggingIn: Bool = false
    // TODO - Change Tabview that when using iOS 18 it uses Tab instead
    
    var body: some Scene {
        WindowGroup {
            if isLoggingIn {
                LoginView()
            } else {
                TabView {
                    ActiviteitenView()
                        .tabItem{
                            Label("Activiteiten", systemImage: "figure.run")
                        }
                    
                    LedenView()
                        .tabItem{
                            Label("Leden", systemImage: "person.3.fill")
                        }
                    
                    ProfielView()
                        .tabItem {
                            Label("Profiel", systemImage: "person.crop.circle")
                        }
                }
                .accentColor(Color.red)
            }
        }
    }
}
