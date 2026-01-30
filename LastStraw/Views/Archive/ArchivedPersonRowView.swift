//
//  ArchivedPersonRowView.swift
//  LastStraw
//

import SwiftUI

struct ArchivedPersonRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    let person: Person
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        AppCard {
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
                if let archivedAt = person.archivedAt {
                    Text(archivedAt.relativeString())
                        .font(.caption)
                        .foregroundColor(theme.mutedForeground)
                }
            }
            .padding(.vertical, 4)
        }
    }
}
