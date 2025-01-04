//
//  ProfielView.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 30/12/2024.
//

import SwiftUI

struct ProfielView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @ObservedObject var viewModel = ProfielViewModel()
    
    var body: some View {
        NavigationStack {
            VStack() {
                if isLoggedIn {
                    Text("Je bent ingelogd")
                    Button(action: { viewModel.logout() }){
                        Text("Log uit")
                    }
                } else {
                    Text("Log in om je accountgegevens te bekijken")
                        .font(.headline)
                        .padding(.bottom)
                    Button(action: { viewModel.toLogin() }){
                        Label("Log in", systemImage:("arrow.right.circle"))
                            .labelStyle(.trailingIcon)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Profiel")
            .alert(isPresented: $viewModel.hasError){
                Alert(title: Text("Fout tijdens het uitloggen"), message: Text(viewModel.error?.localizedDescription ?? "Er is een onbekende fout opgetreden tijdens het uitloggen"))
            }
        }
        .accentColor(.red)
    }
}

struct ProfielView_Previews: PreviewProvider{
    static var previews: some View {
        ProfielView()
    }
}
