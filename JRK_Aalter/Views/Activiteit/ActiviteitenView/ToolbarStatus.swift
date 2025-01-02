//
//  ToolbarStatus.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import SwiftUI

struct ToolbarStatus: View{
    var isLoading: Bool
    var lastUpdated: TimeInterval
    var itemType: String
    var itemCount: Int
    
    var body: some View {
        VStack {
            if isLoading {
                Text("Ophalen van \(itemType)...")
                Spacer()
            } else if lastUpdated == Date.distantFuture.timeIntervalSince1970 {
                Spacer()
                Text("\(itemCount) \(itemType)")
                    .foregroundStyle(.secondary)
            } else {
                let lastUpdatedDate = Date(timeIntervalSince1970: lastUpdated)
                Text("Updated \(lastUpdatedDate.formatted(.relative(presentation: .named)))")
                    .foregroundStyle(.red)
                Text("\(itemCount) \(itemType)")
                    .foregroundStyle(.secondary)
            }
        }
        .font(.caption)
    }
}

struct ToolbarStatus_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarStatus(
            isLoading: true,
            lastUpdated: Date.distantPast.timeIntervalSince1970,
            itemType: "Activiteiten",
            itemCount: 125
        )
        .previewLayout(.fixed(width: 200, height: 40))
        
        ToolbarStatus(
            isLoading: false,
            lastUpdated: Date.distantFuture.timeIntervalSince1970,
            itemType: "Activiteiten",
            itemCount: 10_000
        )
        .previewLayout(.fixed(width: 200, height: 40))
        
        ToolbarStatus(
            isLoading: false,
            lastUpdated: Date.now.timeIntervalSince1970,
            itemType: "Activiteiten",
            itemCount: 10_000
        )
        .previewLayout(.fixed(width: 200, height: 40))
        
        ToolbarStatus(
            isLoading: false,
            lastUpdated: Date.distantPast.timeIntervalSince1970,
            itemType: "Activiteiten",
            itemCount: 10_000
        )
        .previewLayout(.fixed(width: 200, height: 40))
    }
}

   
