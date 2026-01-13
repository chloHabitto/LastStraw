//
//  ContentView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("appearanceMode") private var appearanceModeRawValue: String = AppearanceMode.auto.rawValue
    
    private var appearanceMode: AppearanceMode {
        AppearanceMode(rawValue: appearanceModeRawValue) ?? .auto
    }
    
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
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .tint(.appPrimary)
        .preferredColorScheme(appearanceMode.colorScheme)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Person.self, Straw.self], inMemory: true)
}
