//
//  ActiviteitDetailView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 28/12/2024.
//
import SwiftUI

struct ActiviteitDetailView: View {
    @ObservedObject private var viewModel: ActiviteitDetailViewModel
    
    init(currentActiviteit: Activiteit){
        viewModel = ActiviteitDetailViewModel(currentActiviteit: currentActiviteit)
    }
    
    
    var body: some View {
        List {
            Section(header: Text("Activiteit info")){
                HStack {
                    Label("Activiteit", systemImage: "figure.run")
                    Spacer()
                    Text(viewModel.currentActiviteit.activiteitNaam)
                }
                .accessibilityElement(children: .combine)
                HStack{
                    Label("Datum", systemImage: "calendar")
                    Spacer()
                    Text(GlobalDateFormatter.shared.dateString(from: viewModel.currentActiviteit.datum))
                }
                .accessibilityElement(children: .combine) //  This is used so screenreaders read the two elements  as one statement: "Datum: datum"
                HStack {
                    Label("Prijs", systemImage:"wallet.bifold")
                    Spacer()
                    Text(viewModel.activiteitPrijs())
                }
                .accessibilityElement(children: .combine)
            }
            
            Section(header: Text("Beschrijving")){
                Text(viewModel.currentActiviteit.beschrijving)
            }
            
            if(viewModel.currentActiviteit.moetInschrijven && viewModel.isLoggedIn){
                Section {
                    Button(action: {}){
                        Text("Inschrijven")
                    }
                }
            }
        }
        
        .navigationTitle(viewModel.currentActiviteit.activiteitNaam)
        .toolbar{
            if viewModel.isLeiding {
                Button ("Bewerk"){
                    viewModel.openEditActiviteit()
                }
            }
        }
        .sheet(isPresented: $viewModel.isPresentingEditView){
            NavigationStack {
                ActiviteitEditView(activiteit: $viewModel.edititingActiviteit)
                    .navigationTitle(viewModel.currentActiviteit.activiteitNaam)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Annuleer") {
                                viewModel.isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Bewaar"){
                                Task {
                                    await viewModel.saveActiviteit()
                                }
                            }
                            .disabled(viewModel.isSaving)
                        }
                    }
                    .alert(isPresented: $viewModel.hasError){
                        Alert(title: Text("Waarschuwing"), message: Text(viewModel.error?.localizedDescription ?? "Er is een fout opgetreden"))
                    }
            }.accentColor(Color.red)
        }
        .accentColor(Color.red)
        
    }
}

struct ActiviteitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ActiviteitDetailView(currentActiviteit: Activiteit.sampleData[1])
        }
    }
}
