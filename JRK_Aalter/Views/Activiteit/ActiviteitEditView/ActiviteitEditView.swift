//
//  ActiviteitEditView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 28/12/2024.
//

import SwiftUI

struct ActiviteitEditView: View {
    @ObservedObject private var viewModel: ActiviteitEditViewModel
    
    init(editingActiviteit: Activiteit){
        viewModel = ActiviteitEditViewModel(currentActiviteit: editingActiviteit)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Activiteit info")) {
                TextField("", text:$viewModel.activiteit.activiteitNaam, prompt: Text("Activiteit naam").foregroundColor(.red))
                HStack {
                    DatePicker(selection: $viewModel.activiteit.datum, in:Date()..., displayedComponents: .date){
                        Text("Datum")
                    }
                }
                TextField("", text:$viewModel.activiteit.beschrijving, prompt: Text("Beschrijving").foregroundColor(.red), axis: .vertical)
                    .lineLimit(5...10)
            }
            Section(header: Text("Inschrijvinginfo")){
                HStack {
                    Text("Prijs")
                    Spacer()
                    Slider(value: $viewModel.activiteit.prijs, in: 0...10, step: 0.5){
                        Text("Prijs")
                    }
                    .accessibilityValue(String(format: "€ %.2f", viewModel.activiteit.prijs))
                    Spacer()
                    Text(String(format: "€ %.2f", viewModel.activiteit.prijs))
                        .accessibilityHidden(true)
                }
                Toggle("Met inschrijving", isOn: $viewModel.activiteit.moetInschrijven)
            }
            
            Section(header: Text("Leidinginfo")){
                Picker("Leiding", selection: $viewModel.activiteit.leidingId){
                    ForEach(viewModel.leiding, id: \.id) { leiding in
                        Text("\(leiding.voornaam) \(leiding.achternaam)").tag(leiding.id)
                    }
                }
            }
        }
        .accentColor(Color.red)
        .task {
            print("fetching leiding...")
            await viewModel.fetchLeiding()
        }
        .alert(isPresented: $viewModel.hasError){
            Alert(title: Text("Waarschuwing"), message: Text(viewModel.error?.localizedDescription ?? "Er is een fout opgetreden"))
        }
    }
}

struct ActiviteitEditView_Previews: PreviewProvider {
    static var previews: some View {
        ActiviteitEditView(editingActiviteit: Activiteit.sampleData[0])
    }
}
