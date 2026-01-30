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
            HStack(alignment: .top, spacing: 12) {
                // Emoji on left as standalone element
                Text(straw.emotion.emoji)
                    .font(.title)
                
                // Content on right
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(straw.emotion.label)
                            .font(.display(14, weight: .medium))
                            .foregroundColor(straw.emotion.color)
                        
                        Spacer()
                        
                        Text(straw.date.relativeString())
                            .font(.caption)
                            .foregroundColor(theme.mutedForeground)
                    }
                    
                    // Note in muted color (not foreground)
                    if !straw.note.isEmpty {
                        Text(straw.note)
                            .font(.subheadline)
                            .foregroundColor(theme.mutedForeground)
                            .lineLimit(isExpanded ? nil : 2)
                        
                        if straw.note.count > 80 {
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
    }
}
