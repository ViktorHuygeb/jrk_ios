//
//  ActiviteitCard.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//
import SwiftUI
import Foundation

struct ActiviteitCardView: View {
    var activiteit: Activiteit
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }()
    var body: some View {
        VStack(alignment: .leading){
            Text(activiteit.activiteitNaam)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            HStack{
                Text("\(activiteit.prijs == 0.00 ? "Gratis" : NSString(format: "€ %.2f", activiteit.prijs))")
                    .accessibilityLabel("Deze activiteit \(activiteit.prijs == 0.00 ? "is gratis" : NSString(format: "kost %.2f euro", activiteit.prijs))")
                Spacer()
                Label("\(Self.dateFormatter.string(from: activiteit.datum))", systemImage: "clock")
                    .accessibilityLabel("De activiteit vindt plaats op \(Self.dateFormatter.string(from: activiteit.datum))")
                    .labelStyle(.trailingIcon)
                    
            }.font(.caption)
        }.padding()
    }
}

struct ActiviteitCard_Previews: PreviewProvider {
    static var activiteit = Activiteit.sampleData[0]
    static var previews: some View {
        ActiviteitCardView(activiteit: activiteit)
            .previewLayout(.fixed(width: 400, height: 100))
        
    }
}
