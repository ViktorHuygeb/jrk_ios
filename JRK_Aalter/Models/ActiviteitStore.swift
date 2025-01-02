//
//  ActiviteitStore.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 30/12/2024.
//

import Foundation

@MainActor // Used to make sure that every task that edits the @Published fields gets performed on the main thread
class ActiviteitStore: ObservableObject {
    @Published var activiteiten: [Activiteit] = []
    
    init() {
        Task<_, Error> {
            _ = try await load()
            if (!activiteiten.isEmpty){
                try await save(activiteiten: Activiteit.sampleData)
            }
        }
    }
    
    // We store all our data in a file for now, later we will change this using SwiftData
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("activiteiten.data")
    }
    
    func load() async throws {
        let loadTask = Task<[Activiteit], Error> /* The taks returns [Activiteit] and returns error */ {
            let fileURL = try Self.fileURL()
            
            guard let data = try? /* try? makes it so that when there is an error thrown, the result will be nil. */ Data(contentsOf: fileURL) else {
                return []
            }
            
            let activiteiten = try JSONDecoder().decode([Activiteit].self, from: data)
            return activiteiten
        }
        let loadedActiviteiten = try await loadTask.value
        self.activiteiten = loadedActiviteiten
    }
    
    func save(activiteiten: [Activiteit]) async throws {
//        let saveTask = Task {
//            let activiteitenData = try JSONEncoder().encode(activiteiten)
//            let outfile = try Self.fileURL()
//            try activiteitenData.write(to: outfile)
//        }
//        
//        _ = try await saveTask.value // the _ makes sure that the error gets propagated, but shows that we are not interested in the return of the task
        
    }
}
