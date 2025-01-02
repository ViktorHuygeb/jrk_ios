//
//  ActiviteitenView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//
import SwiftUI

struct ActiviteitenView: View {
    @AppStorage("lastUpdated") var lastUpdated = Date.distantFuture.timeIntervalSince1970
    @StateObject internal var viewModel = ActiviteitenViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack{
            List() {
                ForEach($viewModel.activiteiten){ $activiteit in
                    NavigationLink(destination: ActiviteitDetailView(activiteit: $activiteit)){
                        ActiviteitCardView(activiteit: activiteit)
                    }
                }
                .onDelete(perform: viewModel.deleteActiviteiten(indexes:))
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
            }
            .navigationTitle("Activiteiten")
            .toolbar(content: toolbarContent)
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
