//
//  SettingsMenuItem.swift
//  LastStraw
//

import SwiftUI

/// Reusable menu item for settings main menu: icon in colored container, label, description, chevron.
struct SettingsMenuItem: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let icon: String
    let label: String
    let description: String?
    let isLast: Bool
    let action: () -> Void
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    init(
        icon: String,
        label: String,
        description: String? = nil,
        isLast: Bool = false,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.label = label
        self.description = description
        self.isLast = isLast
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // Icon in 36x36 rounded-xl container with primary/10 background
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(theme.primary.opacity(0.1))
                        .frame(width: 36, height: 36)
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(theme.primary)
                }
                
                // VStack with label and optional description
                VStack(alignment: .leading, spacing: 2) {
                    Text(label)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(theme.foreground)
                    if let description {
                        Text(description)
                            .font(.system(size: 12))
                            .foregroundColor(theme.mutedForeground)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(theme.mutedForeground)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
            .background(theme.primary.opacity(0.05))
        }
        .buttonStyle(SettingsMenuItemButtonStyle(theme: theme))
        .overlay(alignment: .bottom) {
            if !isLast {
                Rectangle()
                    .fill(theme.border.opacity(0.3))
                    .frame(height: 1)
                    .padding(.leading, 16 + 36 + 12)
            }
        }
    }
}

private struct SettingsMenuItemButtonStyle: ButtonStyle {
    let theme: ThemeColors
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
    }
}

#Preview {
    SettingsMenuItem(
        icon: "paintbrush.fill",
        label: "Appearance",
        description: "Theme and accent color",
        isLast: false
    ) { }
    .padding()
    .background(Theme.colors(for: .light).background)
}
