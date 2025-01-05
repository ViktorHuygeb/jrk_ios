//
//  ActiviteitenView.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//
import SwiftUI

struct ActiviteitenView: View {
    @AppStorage("lastUpdated") var lastUpdated = Date.distantFuture.timeIntervalSince1970
    @AppStorage("isLeiding") var isLeiding = false
    @StateObject internal var viewModel = ActiviteitenViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack{
            List() {
                ForEach($viewModel.activiteiten){ $activiteit in
                    NavigationLink(destination: ActiviteitDetailView(currentActiviteit: activiteit)){
                        ActiviteitCardView(activiteit: activiteit)
                    }
                    .id(activiteit.id)
                }
                .onDelete(perform: {indexes in
                    Task {
                        await viewModel.deleteActiviteiten(indexes: indexes)
                    }
                })
                .deleteDisabled(!isLeiding)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
            }
            .navigationTitle("Activiteiten")
            .toolbar(content: toolbarContent)
            .alert(isPresented: $viewModel.hasError){
                Alert(title: Text("Waarschuwing"), message: Text(viewModel.error?.localizedDescription ?? "Er is een fout opgetreden"))
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
