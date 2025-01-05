//
//  ActiviteitDetailView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 28/12/2024.
//
import SwiftUI

struct ActiviteitDetailView: View {
    @AppStorage("isLeiding") var isLeiding: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    @Binding var activiteit: Activiteit
    
    @State private var editingActiviteit = Activiteit.emptyActiviteit
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Activiteit info")){
                HStack {
                    Label("Activiteit", systemImage: "figure.run")
                    Spacer()
                    Text(activiteit.activiteitNaam)
                }
                .accessibilityElement(children: .combine)
                HStack{
                    Label("Datum", systemImage: "calendar")
                    Spacer()
                    Text(GlobalDateFormatter.shared.dateString(from: activiteit.datum))
                }
                .accessibilityElement(children: .combine) //  This is used so screenreaders read the two elements  as one statement: "Datum: datum"
                HStack {
                    Label("Prijs", systemImage:"wallet.bifold")
                    Spacer()
                    Text((activiteit.prijs == 0.00) ? "Gratis" : String(format: "€ %.2f", activiteit.prijs))
                }
                .accessibilityElement(children: .combine)
            }
            
            Section(header: Text("Beschrijving")){
                Text(activiteit.beschrijving)
            }
            
            if(activiteit.moetInschrijven && isLoggedIn){
                Section {
                    Button(action: {}){
                        Text("Inschrijven")
                    }
                }
            }
        }
        .navigationTitle(activiteit.activiteitNaam)
        .toolbar{
            if isLeiding {
                Button ("Bewerk"){
                    editingActiviteit = activiteit
                    isPresentingEditView = true
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationStack {
                ActiviteitEditView(activiteit: $editingActiviteit)
                    .navigationTitle(activiteit.activiteitNaam)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Annuleer") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Bewaar"){
                                isPresentingEditView = false
                                activiteit = editingActiviteit
                            }
                        }
                    }
            }.accentColor(Color.red)
        }
        .accentColor(Color.red)
    }
}

struct ActiviteitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ActiviteitDetailView(activiteit: .constant(Activiteit.sampleData[1]))
        }
    }
}
