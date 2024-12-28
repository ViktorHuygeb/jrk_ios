//
//  ActiviteitEditView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 28/12/2024.
//

import SwiftUI

struct ActiviteitEditView: View {
    @State private var activiteit = Activiteit.emptyActiviteit
    var body: some View {
        Form{
            Section(header: Text("Activiteit info")) {
                TextField("Naam activiteit", text:$activiteit.activiteitNaam) // $ is used to create a binding to the activiteit
                HStack {
                    DatePicker(selection: $activiteit.datum, in:Date.now..., displayedComponents: .date){
                        Text("Datum")
                    }
                }
                TextField("Beschrijving", text:$activiteit.beschrijving, axis: .vertical)
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
        }
        .accentColor(Color.red)
    }
}

struct ActiviteitEditView_Previews: PreviewProvider {
    static var previews: some View {
        ActiviteitEditView()
    }
}
