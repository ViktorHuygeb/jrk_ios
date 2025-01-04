//
//  ProfielView.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 30/12/2024.
//

import SwiftUI

struct ProfielView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("isLeiding") var isLeiding = false
    
    var body: some View {
        NavigationStack {
            VStack() {
                if isLoggedIn {
                   Text("Je bent ingelogd")
                    Button(action: {
                        isLoggedIn = false
                        isLeiding = false
                    }){
                        Text("Log uit")
                    }
                } else {
                    Text("Log in om je accountgegevens te bekijken")
                        .font(.headline)
                        .padding(.bottom)
                    NavigationLink(destination: LoginView()){
                        Label("Log in", systemImage:("arrow.right.circle"))
                            .labelStyle(.trailingIcon)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }.navigationTitle("Profiel")
        }
        .accentColor(.red)
    }
}

struct ProfielView_Previews: PreviewProvider{
    static var previews: some View {
        ProfielView()
    }
}
