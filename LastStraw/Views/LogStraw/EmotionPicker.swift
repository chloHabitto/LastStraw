//
//  EmotionPicker.swift
//  LastStraw
//
//  Single-selection grid of emotions (sad, frustrated, confused, hurt, anxious, let down).
//

import SwiftUI

struct EmotionPicker: View {
    @Binding var selection: Emotion?
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    private let columns = [GridItem(.adaptive(minimum: 100), spacing: 12)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Emotion.allCases, id: \.self) { emotion in
                Button(action: { selection = emotion }) {
                    VStack(spacing: 6) {
                        Text(emotion.emoji)
                            .font(.title)
                        Text(emotion.label)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(selection == emotion ? emotion.color.opacity(0.4) : theme.muted.opacity(0.5))
                    )
                    .foregroundColor(selection == emotion ? emotion.color : theme.foreground)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(emotion.label)
                .accessibilityAddTraits(selection == emotion ? [.isSelected] : [])
            }
        }
    }
}
