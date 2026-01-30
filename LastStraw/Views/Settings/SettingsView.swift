//
//  SettingsView.swift
//  LastStraw
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                List {
                    AppearanceSection()
                    NotificationsSection()
                    PrivacySection()
                    DefaultsSection()
                    DataSection()
                    AboutSection()
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Settings")
        }
    }
}
