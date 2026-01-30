//
//  ContentView.swift
//  LastStraw
//

import SwiftUI
import SwiftData

enum Tab: String, CaseIterable {
    case home
    case archived
    case settings
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .archived: return "archivebox.fill"
        case .settings: return "gearshape.fill"
        }
    }
    
    var label: String { rawValue.capitalized }
}

struct ContentView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var systemColorScheme
    
    private var effectiveColorScheme: ColorScheme {
        settings.themeMode.colorScheme ?? systemColorScheme
    }
    
    private var accent: Color {
        settings.accentColor.color
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(Tab.home.label, systemImage: Tab.home.icon)
                }
            
            ArchiveListView()
                .tabItem {
                    Label(Tab.archived.label, systemImage: Tab.archived.icon)
                }
            
            SettingsView()
                .tabItem {
                    Label(Tab.settings.label, systemImage: Tab.settings.icon)
                }
        }
        .tint(accent)
        .preferredColorScheme(settings.themeMode.colorScheme)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppSettings())
        .modelContainer(for: [Person.self, Straw.self, Bloom.self, ThresholdExtension.self], inMemory: true)
}
