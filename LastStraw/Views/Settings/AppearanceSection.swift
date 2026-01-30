//
//  AppearanceSection.swift
//  LastStraw
//

import SwiftUI

struct AppearanceSection: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        Section {
            Picker("Theme", selection: $settings.themeMode) {
                ForEach(ThemeMode.allCases, id: \.self) { mode in
                    Label(mode.label, systemImage: mode.icon)
                        .tag(mode)
                }
            }
            .foregroundColor(theme.foreground)
            Picker("Accent color", selection: $settings.accentColor) {
                ForEach(AccentColor.allCases, id: \.self) { accent in
                    HStack {
                        Circle()
                            .fill(accent.color)
                            .frame(width: 20, height: 20)
                        Text(accent.label)
                    }
                    .tag(accent)
                }
            }
            .foregroundColor(theme.foreground)
        } header: {
            Text("Appearance")
                .foregroundColor(theme.mutedForeground)
        }
    }
}
