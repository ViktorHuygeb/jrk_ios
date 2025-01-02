//
//  ActiviteitenView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//
import SwiftUI

struct ActiviteitenView: View {
    // TODO - Make toolbarcontent a seperate function to have a top and bottom toolbar
    @StateObject private var viewModel = ActiviteitenViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack{
            List($viewModel.activiteiten, id: \.id) {$activiteit in
                NavigationLink(destination: ActiviteitDetailView(activiteit: $activiteit)){
                    ActiviteitCardView(activiteit: activiteit)
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
            }
            .navigationTitle("Activiteiten")
            .toolbar{
                Button(action: {viewModel.openAddSheet()}){
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $viewModel.isPresentingNewActiviteitView){
            NewActiviteitSheet(activiteiten: $viewModel.activiteiten, isPresentingNewActiviteitVew: $viewModel.isPresentingNewActiviteitView)
                .accentColor(Color.red)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                viewModel.saveActiviteit()
            }
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = .red
        }
        .task {
            await viewModel.fetchActiviteiten()
        }
        .refreshable {
            await viewModel.fetchActiviteiten()
        }
        .accentColor(.red)
    }
}

struct ActiviteitenView_Previews: PreviewProvider{
    static var previews: some View {
        ActiviteitenView()
    }
}
