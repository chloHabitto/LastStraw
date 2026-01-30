//
//  PrivacySection.swift
//  LastStraw
//

import SwiftUI

/// Detail page for privacy: SettingsSection with SettingsRow and toggles.
struct PrivacyDetailView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SettingsSection(title: "Privacy & Security") {
                        VStack(spacing: 0) {
                            SettingsRow(icon: "lock.fill", label: "Require Face ID / Passcode", trailing: { Toggle("", isOn: $settings.requirePasscode).labelsHidden().tint(theme.primary) })
                            divider
                            SettingsRow(icon: "eye.slash.fill", label: "Hide app preview", trailing: { Toggle("", isOn: $settings.hideAppPreview).labelsHidden().tint(theme.primary) })
                            divider
                            SettingsRow(icon: "theatermasks.fill", label: "Stealth mode", description: "Disguise app icon", trailing: { Toggle("", isOn: $settings.disguiseIcon).labelsHidden().tint(theme.primary) })
                        }
                    }
                    
                    Text("🔒 Your privacy matters.")
                        .font(.system(size: 13))
                        .foregroundColor(theme.mutedForeground)
                        .padding(.horizontal, 4)
                }
                .padding(20)
            }
        }
        .navigationTitle("Privacy & Security")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var divider: some View {
        Rectangle()
            .fill(theme.border.opacity(0.3))
            .frame(height: 1)
            .padding(.leading, 16 + 36 + 12)
    }
}

#Preview {
    NavigationStack {
        PrivacyDetailView()
            .environmentObject(AppSettings())
    }
}
