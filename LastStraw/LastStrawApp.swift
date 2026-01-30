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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .modelContainer(for: [Person.self, Straw.self, Bloom.self, ThresholdExtension.self])
        }
    }
}
