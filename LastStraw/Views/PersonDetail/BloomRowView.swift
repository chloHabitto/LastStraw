//
//  BloomRowView.swift
//  LastStraw
//

import SwiftUI

struct BloomRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let bloom: Bloom
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                // Emoji on left
                Text(bloom.feeling.emoji)
                    .font(.title)
                
                // Content on right
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(bloom.feeling.label)
                            .font(.display(14, weight: .medium))
                            .foregroundColor(theme.foreground)
                        
                        // Bloom badge pill
                        Text("bloom")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(accent)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(accent.opacity(0.15))
                            .clipShape(Capsule())
                        
                        Spacer()
                        
                        Text(bloom.date.relativeString())
                            .font(.caption)
                            .foregroundColor(theme.mutedForeground)
                    }
                    
                    if !bloom.note.isEmpty {
                        Text(bloom.note)
                            .font(.subheadline)
                            .foregroundColor(theme.mutedForeground)
                            .lineLimit(2)
                    }
                }
            }
        }
        .padding(16)
        .background(theme.card)
        .background(accent.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(accent.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: theme.primary.opacity(0.1), radius: 8, x: 0, y: 2)
    }
}
