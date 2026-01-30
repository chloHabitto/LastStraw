//
//  LastStrawApp.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

@main
struct LastStrawApp: App {
    @StateObject private var settings = AppSettings()

    private let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Person.self,
            Straw.self,
            Bloom.self,
            ThresholdExtension.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            print("Failed to create ModelContainer: \(error)")
            print("Attempting to delete corrupt store and recreate...")

            let url = URL.applicationSupportDirectory.appending(path: "default.store")
            let fileManager = FileManager.default
            let storePaths = [
                url.path,
                url.path + "-shm",
                url.path + "-wal"
            ]

            for path in storePaths {
                try? fileManager.removeItem(atPath: path)
            }

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer even after clearing store: \(error)")
            }
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
        .modelContainer(sharedModelContainer)
    }
}
