//
//  ContentView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ArchiveListView()
                .tabItem {
                    Label("Archive", systemImage: "archivebox.fill")
                }
        }
        .tint(.appPrimary)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Person.self, Straw.self], inMemory: true)
}
