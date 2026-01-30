//
//  PrivacySection.swift
//  LastStraw
//

import SwiftUI

struct PrivacySection: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        Section {
            Toggle("Require Face ID / Passcode", isOn: $settings.requirePasscode)
                .foregroundColor(theme.foreground)
            Toggle("Hide app preview", isOn: $settings.hideAppPreview)
                .foregroundColor(theme.foreground)
            Toggle("Stealth mode", isOn: $settings.disguiseIcon)
                .foregroundColor(theme.foreground)
        } header: {
            Text("Privacy & Security")
                .foregroundColor(theme.mutedForeground)
        } footer: {
            Text("🔒 Your privacy matters.")
                .foregroundColor(theme.mutedForeground)
        }
    }
}
