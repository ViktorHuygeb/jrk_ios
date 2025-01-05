//
//  ActiviteitEditView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 28/12/2024.
//

import SwiftUI

struct ActiviteitEditView: View {
    @StateObject private var viewModel: ActiviteitEditViewModel = ActiviteitEditViewModel()
    @Binding var activiteit: Activiteit
    
    var body: some View {
        Form {
            Section(header: Text("Activiteit info")) {
                TextField("", text:$activiteit.activiteitNaam, prompt: Text("Activiteit naam").foregroundColor(.red))
                HStack {
                    DatePicker(selection: $activiteit.datum, in:Date()..., displayedComponents: .date){
                        Text("Datum")
                    }
                }
                TextField("", text:$activiteit.beschrijving, prompt: Text("Beschrijving").foregroundColor(.red), axis: .vertical)
                    .lineLimit(5...10)
            }
            Section(header: Text("Inschrijvinginfo")){
                HStack {
                    Text("Prijs")
                    Spacer()
                    Slider(value: $activiteit.prijs, in: 0...10, step: 0.5){
                        Text("Prijs")
                    }
                    .accessibilityValue(String(format: "€ %.2f", activiteit.prijs))
                    Spacer()
                    Text(String(format: "€ %.2f", activiteit.prijs))
                        .accessibilityHidden(true)
                }
                Toggle("Met inschrijving", isOn: $activiteit.moetInschrijven)
            }
            
            Section(header: Text("Leidinginfo")){
                Picker("Leiding", selection: $activiteit.leidingId){
                    ForEach(viewModel.leiding) { leiding in
                        Text("\(leiding.voornaam) \(leiding.achternaam)").tag(leiding.id)
                    }
                }
            }
        }
        .accentColor(Color.red)
        .task {
            await viewModel.fetchLeiding()
        }
        .alert(isPresented: $viewModel.hasError){
            Alert(title: Text("Waarschuwing"), message: Text(viewModel.error?.localizedDescription ?? "Er is een fout opgetreden"))
        }
    }
}

struct ActiviteitEditView_Previews: PreviewProvider {
    static var previews: some View {
        ActiviteitEditView(activiteit: .constant(Activiteit.sampleData[0]))
    }
}
