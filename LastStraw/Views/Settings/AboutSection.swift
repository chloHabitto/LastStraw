//
//  AboutSection.swift
//  LastStraw
//

import SwiftUI

struct WhyThisAppView: View {
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("A place to believe yourself, until you're ready to decide.")
                        .font(.display(20, weight: .semibold))
                        .foregroundColor(theme.foreground)
                    Text("LastStraw helps you notice patterns in relationships without judgment. Log moments, set a threshold, and when you've seen enough you can choose to archive, extend, or keep observing—on your own terms.")
                        .font(.body)
                        .foregroundColor(theme.mutedForeground)
                }
                .padding(20)
            }
        }
        .navigationTitle("Why this app exists")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// Detail page for about: version, why this app, feedback, rate, privacy, terms using SettingsRow.
struct AboutDetailView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SettingsSection(title: "About") {
                        VStack(spacing: 0) {
                            SettingsRow(label: "Version", trailing: { Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0").font(.system(size: 15)).foregroundColor(theme.mutedForeground) })
                            rowDivider
                            NavigationLink {
                                WhyThisAppView()
                            } label: {
                                SettingsRow(label: "Why this app exists", showChevron: true, trailing: { EmptyView() })
                            }
                            .buttonStyle(.plain)
                            rowDivider
                            Link(destination: URL(string: "mailto:feedback@example.com")!) {
                                SettingsRow(label: "Send feedback", showChevron: true, trailing: { Image(systemName: "arrow.up.right").font(.caption).foregroundColor(theme.mutedForeground) })
                            }
                            rowDivider
                            Link(destination: URL(string: "https://apps.apple.com/app/id")!) {
                                SettingsRow(label: "Rate the app", showChevron: true, trailing: { EmptyView() })
                            }
                            rowDivider
                            Link(destination: URL(string: "https://example.com/privacy")!) {
                                SettingsRow(label: "Privacy policy", showChevron: true, trailing: { EmptyView() })
                            }
                            rowDivider
                            Link(destination: URL(string: "https://example.com/terms")!) {
                                SettingsRow(label: "Terms of use", showChevron: true, trailing: { EmptyView() })
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var rowDivider: some View {
        Rectangle()
            .fill(theme.border.opacity(0.3))
            .frame(height: 1)
            .padding(.leading, 16)
    }
}

#Preview {
    NavigationStack {
        AboutDetailView()
            .environmentObject(AppSettings())
    }
}
