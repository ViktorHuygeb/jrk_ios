//
//  ContentView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ActiviteitenView(activiteiten: Activiteit.sampleData)
                .navigationTitle("Activiteiten")
        }
    }
}

#Preview {
    ContentView()
}
