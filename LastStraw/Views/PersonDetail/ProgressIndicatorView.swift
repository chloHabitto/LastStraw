//
//  ProgressIndicatorView.swift
//  LastStraw
//

import SwiftUI

struct ProgressIndicatorView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let person: Person
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    private var bloomCount: Int { person.blooms?.count ?? 0 }
    private var extensionCount: Int { person.thresholdExtensions?.count ?? 0 }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Dynamic "Observing mode" vs "Your threshold" label
            HStack {
                Text(person.thresholdState == .observing ? "Observing mode" : "Your threshold")
                    .font(.subheadline)
                    .foregroundColor(theme.mutedForeground)
                Spacer()
                if person.thresholdState == .observing {
                    HStack(spacing: 4) {
                        Image(systemName: "eye.fill")
                            .font(.caption)
                        Text("\(person.threshold)")
                            .font(.display(18, weight: .bold))
                    }
                    .foregroundColor(theme.mutedForeground)
                } else {
                    Text("\(person.strawCount)/\(person.threshold)")
                        .font(.display(18, weight: .bold))
                        .foregroundColor(person.hasReachedThreshold ? theme.destructive : theme.foreground)
                }
            }
            
            ThresholdDotsView(person: person)
            
            // Observing mode info box
            if person.thresholdState == .observing {
                HStack(spacing: 8) {
                    Image(systemName: "eye.fill")
                        .font(.caption)
                    Text("You're in observing mode. Keep logging moments without pressure.")
                        .font(.footnote)
                }
                .foregroundColor(theme.mutedForeground)
                .padding(12)
                .background(theme.secondary.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // Bloom count badge
            if bloomCount > 0 {
                HStack(spacing: 6) {
                    Text("🌸")
                        .font(.subheadline)
                    Text("\(bloomCount) bloom\(bloomCount != 1 ? "s" : "") logged")
                        .font(.footnote)
                        .foregroundColor(theme.mutedForeground)
                }
                .padding(.top, 4)
            }
            
            // Extension history (when extensions exist and not observing)
            if extensionCount > 0 && person.thresholdState != .observing {
                HStack(spacing: 6) {
                    Image(systemName: "clock.fill")
                        .font(.caption)
                    Text("Extended \(extensionCount) time\(extensionCount != 1 ? "s" : "")")
                        .font(.footnote)
                }
                .foregroundColor(theme.mutedForeground)
                .padding(.top, 4)
            }
        }
    }
}
