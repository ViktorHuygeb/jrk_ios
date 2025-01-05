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
                Text("Je bent ingelogd")
                Button(action: { viewModel.logout() }){
                    Text("Log uit")
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
