//
//  ErrorView.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 30/12/2024.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            VStack {
            Text("Er is een fout opgetreden!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            Text(errorWrapper.error.localizedDescription)
                .font(.headline)
            Text(errorWrapper.guidance)
                .font(.caption)
                .padding(.top)
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Negeer"){
                    dismiss()
                }
            }
        }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "Deze error kan je veilig negeren")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
