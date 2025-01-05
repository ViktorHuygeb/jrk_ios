//
//  JRK_IOSApp.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//

import SwiftUI

@main
struct JRK_Aalter: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("isLeiding") var isLeiding: Bool = false
    
    // TODO - Change Tabview that when using iOS 18 it uses Tab instead
    var body: some Scene {
        WindowGroup {
            TabView {
                if isLoggedIn {
                    ActiviteitenView()
                        .tabItem{
                            Label("Activiteiten", systemImage: "figure.run")
                        }
                    if isLeiding {
                        LedenView()
                            .tabItem{
                                Label("Leden", systemImage: "person.3.fill")
                            }
                    }
                    
                    ProfielView()
                        .tabItem {
                            Label("Profiel", systemImage: "person.crop.circle")
                        }
                    
                } else {
                    LoginView()
                        .tabItem{
                            Label("Log in", systemImage: "person.badge.key.fill")
                        }
                    ActiviteitenView()
                        .tabItem{
                            Label("Activiteiten", systemImage: "figure.run")
                        }
                }
            }
            .accentColor(Color.red)
        }
    }
}
