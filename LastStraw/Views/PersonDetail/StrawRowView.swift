//
//  StrawRowView.swift
//  LastStraw
//

import SwiftUI

struct StrawRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    let straw: Straw
    @State private var isExpanded = false
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(straw.emotion.emoji)
                        .font(.title2)
                    Text(straw.emotion.label)
                        .font(.display(14, weight: .medium))
                        .foregroundColor(straw.emotion.color)
                    Spacer()
                    Text(straw.date.relativeString())
                        .font(.caption)
                        .foregroundColor(theme.mutedForeground)
                }
                
                Text(straw.note)
                    .font(.body)
                    .foregroundColor(theme.foreground)
                    .lineLimit(isExpanded ? nil : 2)
                
                if isExpanded && !straw.note.isEmpty {
                    Button(action: { isExpanded.toggle() }) {
                        Image(systemName: "chevron.up")
                            .font(.caption)
                            .foregroundColor(theme.mutedForeground)
                    }
                } else if straw.note.count > 60 {
                    Button(action: { isExpanded.toggle() }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.caption)
                            .foregroundColor(theme.mutedForeground)
                    }
                }
            }
        }
    }
}
