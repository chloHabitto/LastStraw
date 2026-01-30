//
//  SettingsSection.swift
//  LastStraw
//

import SwiftUI

/// Wrapper for detail page sections: title (uppercase, muted) + content in bubble card.
struct SettingsSection<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    @ViewBuilder let content: () -> Content
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .medium))
                .tracking(1.2)
                .foregroundColor(theme.mutedForeground)
            
            content()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(theme.card)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(theme.border.opacity(0.5), lineWidth: 1)
                )
                .shadow(color: theme.primary.opacity(0.12), radius: 12, x: 0, y: 2)
        }
    }
}

#Preview {
    SettingsSection(title: "Appearance") {
        Text("Section content")
            .foregroundColor(Theme.colors(for: .light).foreground)
    }
    .padding()
    .background(Theme.colors(for: .light).background)
}
