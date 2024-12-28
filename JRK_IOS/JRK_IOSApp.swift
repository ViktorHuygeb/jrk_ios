//
//  JRK_IOSApp.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//

import SwiftUI

@main
struct JRK_IOSApp: App {
    @State private var activiteiten = Activiteit.sampleData
    var body: some Scene {
        WindowGroup {
            ActiviteitenView(activiteiten: $activiteiten)
        }
    }
}
