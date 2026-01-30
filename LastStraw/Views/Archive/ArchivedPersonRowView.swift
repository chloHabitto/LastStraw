//
//  ArchivedPersonRowView.swift
//  LastStraw
//

import SwiftUI

struct ArchivedPersonRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    @State private var isPressed = false
    let person: Person

    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    private var bloomCount: Int { person.blooms?.count ?? 0 }
    private var hasBlooms: Bool { bloomCount > 0 }

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: 8) {
                // Row 1: Avatar + Name/Relationship + Bloom indicator
                HStack(spacing: 14) {
                    // Avatar circle with shadow
                    Circle()
                        .fill(person.color)
                        .frame(width: 44, height: 44)
                        .overlay(
                            Text(person.initial)
                                .font(.display(18, weight: .bold))
                                .foregroundColor(.white)
                        )
                        .shadow(color: theme.primary.opacity(0.12), radius: 4, x: 0, y: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(person.name)
                            .font(.display(18, weight: .semibold))
                            .foregroundColor(theme.foreground)
                        Text(person.relationship)
                            .font(.subheadline)
                            .foregroundColor(theme.mutedForeground)
                    }

                    Spacer()

                    if hasBlooms {
                        HStack(spacing: 4) {
                            Text("🌸")
                            Text("\(bloomCount)")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(theme.accentForeground)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(accent.opacity(0.1))
                        .clipShape(Capsule())
                    }

                    if let archivedAt = person.archivedAt {
                        Text(archivedAt.relativeString())
                            .font(.caption)
                            .foregroundColor(theme.mutedForeground)
                    }
                }

                // Row 2: Threshold dots + Status badge
                HStack {
                    ThresholdDotsView(person: person)
                    Spacer()
                    // Status badge pill
                    Text("\(person.strawCount)/\(person.threshold)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(person.hasReachedThreshold ? theme.destructiveForeground : theme.mutedForeground)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(person.hasReachedThreshold ? theme.destructive.opacity(0.2) : theme.muted.opacity(0.5))
                        .clipShape(Capsule())
                }

                // Row 3: Threshold message (if at threshold)
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
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeOut(duration: 0.3), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in if !isPressed { isPressed = true } }
                .onEnded { _ in isPressed = false }
        )
    }
}
