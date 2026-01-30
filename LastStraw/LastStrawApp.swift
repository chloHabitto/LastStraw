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
        let storeURL = URL.applicationSupportDirectory.appending(path: "default.store")

        // One-time store reset to clear schema migration issues. Remove after testing.
        let fileManager = FileManager.default
        for suffix in ["", "-shm", "-wal"] {
            let path = storeURL.path + suffix
            try? fileManager.removeItem(atPath: path)
        }

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let storePath = container.configurations.first?.url.path ?? storeURL.path
            print("📂 SwiftData store path: \(storePath)")
            return container
        } catch {
            print("Failed to create ModelContainer: \(error)")
            print("Attempting to delete corrupt store and recreate...")

            for suffix in ["", "-shm", "-wal"] {
                let path = storeURL.path + suffix
                try? fileManager.removeItem(atPath: path)
            }

            do {
                let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
                let storePath = container.configurations.first?.url.path ?? storeURL.path
                print("📂 SwiftData store path: \(storePath)")
                return container
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
