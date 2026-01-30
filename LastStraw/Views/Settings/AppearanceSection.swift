//
//  AppearanceSection.swift
//  LastStraw
//

import SwiftUI

/// Detail page for appearance: custom theme segmented control (pill buttons) and circular accent color swatches.
struct AppearanceDetailView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Theme: pill segmented control (Auto / Light / Dark with icons) in muted background
                    SettingsSection(title: "Theme") {
                        HStack(spacing: 8) {
                            ForEach(ThemeMode.allCases, id: \.self) { mode in
                                themePillButton(mode: mode)
                            }
                        }
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(theme.muted)
                        )
                    }
                    
                    // Accent color: circular swatches, active has ring + scale
                    SettingsSection(title: "Accent color") {
                        HStack(spacing: 16) {
                            ForEach(AccentColor.allCases, id: \.self) { accent in
                                colorSwatch(accent: accent)
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func themePillButton(mode: ThemeMode) -> some View {
        let isActive = settings.themeMode == mode
        return Button {
            settings.themeMode = mode
        } label: {
            HStack(spacing: 6) {
                Image(systemName: mode.icon)
                    .font(.system(size: 14))
                Text(mode.label)
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(isActive ? theme.foreground : theme.mutedForeground)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isActive ? theme.card : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(theme.border.opacity(isActive ? 0.5 : 0.3), lineWidth: 1)
            )
            .shadow(color: isActive ? theme.primary.opacity(0.08) : .clear, radius: 6, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
    
    private func colorSwatch(accent: AccentColor) -> some View {
        let isActive = settings.accentColor == accent
        return Button {
            settings.accentColor = accent
        } label: {
            Circle()
                .fill(accent.color)
                .frame(width: 28, height: 28)
                .overlay(
                    Circle()
                        .stroke(theme.foreground, lineWidth: isActive ? 2 : 0)
                )
                .scaleEffect(isActive ? 1.1 : 1)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        AppearanceDetailView()
            .environmentObject(AppSettings())
    }
}
