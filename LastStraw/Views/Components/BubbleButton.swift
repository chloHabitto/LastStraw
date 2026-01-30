//
//  BubbleButton.swift
//  LastStraw
//

import SwiftUI

struct BubbleButton: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    let action: () -> Void
    var isDisabled: Bool = false
    var style: BubbleButtonStyle = .primary
    
    enum BubbleButtonStyle {
        case primary
        case secondary
    }
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(style == .primary ? theme.primaryForeground : theme.primary)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 44)
                .background(style == .primary ? theme.primary : Color.clear)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(style == .secondary ? theme.primary : Color.clear, lineWidth: 2)
                )
        }
        .buttonStyle(BubbleButtonPressStyle())
        .shadow(color: theme.primary.opacity(style == .primary ? 0.15 : 0), radius: 12, x: 0, y: 4)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1.0)
    }
}

private struct BubbleButtonPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: 16) {
        BubbleButton(title: "Save", action: {})
        BubbleButton(title: "Cancel", action: {}, style: .secondary)
    }
    .padding()
    .background(Theme.colors(for: .light).background)
}
