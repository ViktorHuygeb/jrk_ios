//
//  ActiviteitenView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//

import SwiftUI

struct ActiviteitenView: View {
    var activiteiten: [Activiteit]
    var body: some View {
        List(activiteiten, id: \.id) {activiteit in
            ActiviteitCardView(activiteit: activiteit)
                .listRowInsets(.init())
        }
    }
}

struct ActiviteitenView_Previews: PreviewProvider{
    static var previews: some View {
        ActiviteitenView(activiteiten: Activiteit.sampleData)
    }
}
