//
//  NewActiviteitSheet.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 30/12/2024.
//

import SwiftUI

struct NewActiviteitSheet: View {
    @State var newActiviteit = Activiteit.emptyActiviteit
    
    @Binding var activiteiten: [Activiteit]
    @Binding var isPresentingNewActiviteitVew: Bool
    
    var body: some View {
        NavigationStack{
            ActiviteitEditView(activiteit: $newActiviteit)
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Annuleer") {
                            isPresentingNewActiviteitVew = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Sla op") {
                            activiteiten.append(newActiviteit)
                            isPresentingNewActiviteitVew = false
                        }
                    }
                }
        }
    }
}

struct NewActiviteitSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewActiviteitSheet(activiteiten: .constant(Activiteit.sampleData), isPresentingNewActiviteitVew: .constant(true))
    }
}
