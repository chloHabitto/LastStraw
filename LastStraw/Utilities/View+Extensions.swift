//
//  View+Extensions.swift
//  LastStraw
//

import SwiftUI

// MARK: - Typography

extension Font {
    /// Display/headings: rounded, semibold (mimics Quicksand).
    static func display(_ size: CGFloat, weight: Font.Weight = .semibold) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
}

// MARK: - Bubble card modifier

struct BubbleCard: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        let theme = Theme.colors(for: colorScheme)
        content
            .background(theme.card)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .shadow(color: theme.primary.opacity(0.15), radius: 20, x: 0, y: 4)
            .shadow(color: theme.bubbleGlow.opacity(0.2), radius: 40, x: 0, y: 8)
    }
}

extension View {
    func bubbleCard() -> some View {
        modifier(BubbleCard())
    }
}

// MARK: - Bubble button style

struct BubbleButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        let theme = Theme.colors(for: colorScheme)
        configuration.label
            .font(.headline)
            .foregroundColor(theme.primaryForeground)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(
                LinearGradient(
                    colors: [theme.primary, theme.primary.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(Capsule())
            .shadow(color: theme.primary.opacity(0.3), radius: 8, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
    }
}

// MARK: - Animations

extension View {
    func fadeIn(delay: Double = 0) -> some View {
        self
            .opacity(0)
            .animation(.easeOut(duration: 0.4).delay(delay), value: true)
    }
}

struct PulseSoft: ViewModifier {
    @State private var isPulsing = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isPulsing ? 1 : 0.8)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    isPulsing = true
                }
            }
    }
}

extension View {
    func pulseSoft() -> some View {
        modifier(PulseSoft())
    }
}
