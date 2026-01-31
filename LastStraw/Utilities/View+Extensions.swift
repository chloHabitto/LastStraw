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

/// Staggered fade-in: opacity 0→1 and offset y 10→0 with optional delay (e.g. index * 0.1).
struct FadeInModifier: ViewModifier {
    let delay: Double
    @State private var appeared = false

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 10)
            .onAppear {
                appeared = false
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        appeared = true
                    }
                }
            }
            .onDisappear {
                appeared = false
            }
    }
}

extension View {
    /// Fade in with optional delay for staggered list animations.
    func fadeIn(delay: Double = 0) -> some View {
        modifier(FadeInModifier(delay: delay))
    }
}

// MARK: - Scale-In Animation (for cards appearing)

struct ScaleInModifier: ViewModifier {
    let delay: Double
    @State private var appeared = false

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            .scaleEffect(appeared ? 1 : 0.95)
            .onAppear {
                appeared = false
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        appeared = true
                    }
                }
            }
            .onDisappear {
                appeared = false
            }
    }
}

extension View {
    func scaleIn(delay: Double = 0) -> some View {
        modifier(ScaleInModifier(delay: delay))
    }
}

// MARK: - Gentle Bounce Animation (for emphasis)

struct GentleBounce: ViewModifier {
    @State private var isBouncing = false

    func body(content: Content) -> some View {
        content
            .offset(y: isBouncing ? -4 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    isBouncing = true
                }
            }
    }
}

extension View {
    func gentleBounce() -> some View {
        modifier(GentleBounce())
    }
}

// MARK: - Screen Appear Animation (for full views)

struct ScreenAppearModifier: ViewModifier {
    @State private var appeared = false

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 20)
            .onAppear {
                appeared = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        appeared = true
                    }
                }
            }
            .onDisappear {
                appeared = false
            }
    }
}

extension View {
    func screenAppear() -> some View {
        modifier(ScreenAppearModifier())
    }
}

struct PulseSoft: ViewModifier {
    @State private var isPulsing = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isPulsing ? 1 : 0.8)
            .onAppear {
                isPulsing = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        isPulsing = true
                    }
                }
            }
            .onDisappear {
                isPulsing = false
            }
    }
}

extension View {
    func pulseSoft() -> some View {
        modifier(PulseSoft())
    }
}
