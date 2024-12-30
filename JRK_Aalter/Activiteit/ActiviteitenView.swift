//
//  ActiviteitenView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//
import SwiftUI

struct ActiviteitenView: View {
    @Binding var activiteiten: [Activiteit]
    @Environment(\.scenePhase) private var scenePhase
    @State var isPresentingNewActiviteitView = false
    
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack{
            List($activiteiten, id: \.id) {$activiteit in
                NavigationLink(destination: ActiviteitDetailView(activiteit: $activiteit)){
                    ActiviteitCardView(activiteit: activiteit)
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
            }
            .navigationTitle("Activiteiten")
            .toolbar{
                Button(action: {isPresentingNewActiviteitView = true}){
                    Image(systemName: "plus")
                }
            }
        }
        .accentColor(Color.red)
        .sheet(isPresented: $isPresentingNewActiviteitView){
            NewActiviteitSheet(activiteiten: $activiteiten, isPresentingNewActiviteitVew: $isPresentingNewActiviteitView)
                .accentColor(Color.red)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                saveAction()
            }
        }
    }
}

struct ActiviteitenView_Previews: PreviewProvider{
    static var previews: some View {
        ActiviteitenView(activiteiten: .constant(Activiteit.sampleData), saveAction: {})
    }
}