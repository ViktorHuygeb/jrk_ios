//
//  LoginView.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 03/01/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .disabled(viewModel.isAuthenticating)
                    SecureField("Wachtwoord", text: $viewModel.password)
                        .textContentType(.password)
                        .disabled(viewModel.isAuthenticating)
                }
//                
                Button("Login") {
                    Task {
                        await viewModel.login()
                    }
                }.disabled(viewModel.isAuthenticating)
            }
            .navigationTitle("Inloggen")
        }
        .accentColor(.red)
        .alert(isPresented: $viewModel.hasError){
            Alert(title: Text("Waarschuwing"), message: Text(viewModel.error?.localizedDescription ?? "Er is een fout opgetreden"))
        }
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
