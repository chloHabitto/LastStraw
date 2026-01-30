//
//  AboutSection.swift
//  LastStraw
//

import SwiftUI

struct WhyThisAppView: View {
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("A place to believe yourself, until you're ready to decide.")
                    .font(.display(20, weight: .semibold))
                    .foregroundColor(theme.foreground)
                Text("LastStraw helps you notice patterns in relationships without judgment. Log moments, set a threshold, and when you've seen enough you can choose to archive, extend, or keep observing—on your own terms.")
                    .font(.body)
                    .foregroundColor(theme.mutedForeground)
            }
            .padding()
        }
        .navigationTitle("Why this app exists")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutSection: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        Section {
            HStack {
                Text("Version")
                    .foregroundColor(theme.foreground)
                Spacer()
                Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                    .foregroundColor(theme.mutedForeground)
            }
            NavigationLink {
                WhyThisAppView()
            } label: {
                Text("Why this app exists")
                    .foregroundColor(theme.foreground)
            }
            Link(destination: URL(string: "mailto:feedback@example.com")!) {
                HStack {
                    Text("Send feedback")
                        .foregroundColor(theme.foreground)
                    Spacer()
                    Image(systemName: "arrow.up.right")
                        .font(.caption)
                        .foregroundColor(theme.mutedForeground)
                }
            }
            Link("Rate the app", destination: URL(string: "https://apps.apple.com/app/id")!)
                .foregroundColor(theme.foreground)
            Link("Privacy policy", destination: URL(string: "https://example.com/privacy")!)
                .foregroundColor(theme.foreground)
            Link("Terms of use", destination: URL(string: "https://example.com/terms")!)
                .foregroundColor(theme.foreground)
        } header: {
            Text("About")
                .foregroundColor(theme.mutedForeground)
        } footer: {
            VStack(alignment: .leading, spacing: 8) {
                Text("A place to believe yourself, until you're ready to decide.")
                    .font(.footnote)
                    .foregroundColor(theme.mutedForeground)
            }
        }
    }
}
