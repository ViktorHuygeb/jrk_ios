//
//  LoginView.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 03/01/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack{
            Text("Log in")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Form {
                Section{
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .disabled(viewModel.isAuthenticating)
                    SecureField("Password", text: $viewModel.password)
                        .disabled(viewModel.isAuthenticating)
                }
                
                Button("Login") {
                    Task {
                        await viewModel.login()
                    }
                }.disabled(viewModel.isAuthenticating)
            }
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
