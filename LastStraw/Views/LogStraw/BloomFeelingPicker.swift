//
//  BloomFeelingPicker.swift
//  LastStraw
//

import SwiftUI

struct BloomFeelingPicker: View {
    @Binding var selection: BloomFeeling
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    private let columns = [GridItem(.adaptive(minimum: 100), spacing: 12)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(BloomFeeling.allCases, id: \.self) { feeling in
                Button(action: { selection = feeling }) {
                    VStack(spacing: 6) {
                        Text(feeling.emoji)
                            .font(.title)
                        Text(feeling.label)
                            .font(.caption)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(selection == feeling ? accent.opacity(0.3) : theme.muted.opacity(0.5))
                    )
                    .foregroundColor(selection == feeling ? accent : theme.foreground)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("\(feeling.label)")
                .accessibilityAddTraits(selection == feeling ? [.isSelected] : [])
            }
        }
    }
}
