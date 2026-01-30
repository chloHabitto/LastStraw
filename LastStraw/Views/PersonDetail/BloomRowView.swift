//
//  BloomRowView.swift
//  LastStraw
//

import SwiftUI

struct BloomRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    let bloom: Bloom
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        AppCard {
            HStack(spacing: 12) {
                Text(bloom.feeling.emoji)
                    .font(.title2)
                Text("🌸")
                    .font(.caption)
                Text(bloom.feeling.label)
                    .font(.display(14, weight: .medium))
                    .foregroundColor(theme.foreground)
                Spacer()
                Text(bloom.date.relativeString())
                    .font(.caption)
                    .foregroundColor(theme.mutedForeground)
            }
            if !bloom.note.isEmpty {
                Text(bloom.note)
                    .font(.body)
                    .foregroundColor(theme.mutedForeground)
                    .padding(.top, 8)
            }
        }
    }
}
