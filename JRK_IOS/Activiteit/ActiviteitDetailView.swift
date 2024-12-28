//
//  ActiviteitDetailView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 28/12/2024.
//
import SwiftUI

struct ActiviteitDetailView: View {
    let activiteit: Activiteit
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }()
    
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
                    Text(Self.dateFormatter.string(from: activiteit.datum))
                }
                .accessibilityElement(children: .combine) //  This is used so screenreaders read the two elements  as one statement: "Datum: datum"
                HStack {
                    Label("Prijs", systemImage:"wallet.bifold")
                    Spacer()
                    Text((activiteit.prijs == 0.00) ? "Gratis" : String(format: "€ %.2f", activiteit.prijs))
                }
                .accessibilityElement(children: .combine)
            }
            .accentColor(Color.red)
            
            Section(header: Text("Beschrijving")){
                Text(activiteit.beschrijving)
            }
            
            if(activiteit.moetInschrijven){
                Section {
                    Button(action: {}){
                        Text("Inschrijven")
                    }.accentColor(Color.red)
                }
            }
        }
    }
}

struct ActiviteitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ActiviteitDetailView(activiteit: Activiteit.sampleData[1])
        }
    }
}
