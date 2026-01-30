//
//  PersonRowView.swift
//  LastStraw
//

import SwiftUI

struct PersonRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let person: Person
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 14) {
                    Circle()
                        .fill(person.color)
                        .frame(width: 44, height: 44)
                        .overlay(
                            Text(person.initial)
                                .font(.display(18, weight: .bold))
                                .foregroundColor(.white)
                        )
                    VStack(alignment: .leading, spacing: 4) {
                        Text(person.name)
                            .font(.display(18, weight: .semibold))
                            .foregroundColor(theme.foreground)
                        Text(person.relationship)
                            .font(.subheadline)
                            .foregroundColor(theme.mutedForeground)
                    }
                    Spacer()
                    if !(person.blooms ?? []).isEmpty {
                        HStack(spacing: 4) {
                            Text("🌸")
                                .font(.caption)
                            Text("\((person.blooms ?? []).count)")
                                .font(.caption)
                                .foregroundColor(theme.mutedForeground)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(accent.opacity(0.1))
                        .clipShape(Capsule())
                    }
                }
                HStack {
                    ThresholdDotsView(person: person)
                    Spacer()
                    Text("\(person.strawCount)/\(person.threshold)")
                        .font(.display(14, weight: .medium))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            person.hasReachedThreshold
                                ? theme.destructive.opacity(0.2)
                                : theme.muted
                        )
                        .foregroundColor(
                            person.hasReachedThreshold
                                ? theme.destructive
                                : theme.mutedForeground
                        )
                        .clipShape(Capsule())
                }
                if person.hasReachedThreshold {
                    Text("Time to take stock? 💭")
                        .font(.footnote)
                        .italic()
                        .foregroundColor(theme.mutedForeground)
                }
            }
            .padding(.vertical, 4)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(person.hasReachedThreshold ? theme.destructive.opacity(0.3) : Color.clear, lineWidth: 2)
        )
    }
}
