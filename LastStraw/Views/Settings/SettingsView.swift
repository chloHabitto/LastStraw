//
//  SettingsView.swift
//  LastStraw
//

import SwiftUI

enum SettingsRoute: Hashable {
    case profile
    case appearance
    case notifications
    case privacy
    case defaults
    case data
    case about
}

struct SettingsView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    @State private var path = NavigationPath()
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                theme.background.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Custom header (not navigationTitle)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Settings")
                                .font(.display(28, weight: .bold))
                                .foregroundColor(theme.foreground)
                            Text(AppCopy.settingsSubtitle)
                                .font(.system(size: 15))
                                .foregroundColor(theme.mutedForeground)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        
                        // Group 1: Profile (standalone)
                        settingsCard {
                            SettingsMenuItem(icon: "person.fill", label: "Profile", description: "Your personal info", isLast: true) { path.append(SettingsRoute.profile) }
                        }
                        
                        // Group 2: Main Settings (3 items)
                        settingsCard {
                            SettingsMenuItem(icon: "paintbrush.fill", label: "Appearance", description: "Theme, colors", isLast: false) { path.append(SettingsRoute.appearance) }
                            SettingsMenuItem(icon: "bell.fill", label: "Notifications", description: "Reminders & check-ins", isLast: false) { path.append(SettingsRoute.notifications) }
                            SettingsMenuItem(icon: "lock.fill", label: "Privacy & Security", description: "Lock, hide, protect", isLast: true) { path.append(SettingsRoute.privacy) }
                        }
                        
                        // Group 3: Customization (2 items)
                        settingsCard {
                            SettingsMenuItem(icon: "slider.horizontal.3", label: "Defaults", description: "Threshold, emotions", isLast: false) { path.append(SettingsRoute.defaults) }
                            SettingsMenuItem(icon: "externaldrive.fill", label: "Your Data", description: "Export, delete", isLast: true) { path.append(SettingsRoute.data) }
                        }
                        
                        // Group 4: About (standalone)
                        settingsCard {
                            SettingsMenuItem(icon: "info.circle.fill", label: "About", description: "Version, legal, feedback", isLast: true) { path.append(SettingsRoute.about) }
                        }
                        
                        // Footer: Heart icon + mission tagline
                        VStack(spacing: 8) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 20))
                                .foregroundColor(theme.primary.opacity(0.4))
                            Text("\u{201C}A place to believe yourself,\nuntil you're ready to decide.\u{201D}")
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .italic()
                                .foregroundColor(theme.mutedForeground)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 16)
                        .padding(.bottom, 32)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: SettingsRoute.self) { route in
                switch route {
                case .profile: ProfileDetailView()
                case .appearance: AppearanceDetailView()
                case .notifications: NotificationsDetailView()
                case .privacy: PrivacyDetailView()
                case .defaults: DefaultsDetailView()
                case .data: DataDetailView()
                case .about: AboutDetailView()
                }
            }
        }
    }
    
    @ViewBuilder
    private func settingsCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 0) {
            content()
        }
        .background(theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(theme.border.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: theme.primary.opacity(0.12), radius: 12, x: 0, y: 2)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppSettings())
}
