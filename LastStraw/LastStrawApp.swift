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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Person.self, Straw.self])
        }
    }
}
