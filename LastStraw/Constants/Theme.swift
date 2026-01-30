//
//  Theme.swift
//  LastStraw
//
//  Y2K-inspired soft bubble aesthetic. All colors use HSB (hue 0–1, saturation 0–1, brightness 0–1).
//

import SwiftUI

// MARK: - Theme Colors (light/dark)

struct Theme {
    
    /// Returns semantic colors for the given color scheme.
    static func colors(for colorScheme: ColorScheme) -> ThemeColors {
        colorScheme == .dark ? dark : light
    }
    
    static let light = ThemeColors(
        background: Color(hue: 0.75, saturation: 0.50, brightness: 0.98),
        foreground: Color(hue: 0.75, saturation: 0.30, brightness: 0.25),
        card: Color.white,
        cardForeground: Color(hue: 0.75, saturation: 0.30, brightness: 0.25),
        primary: Color(hue: 0.75, saturation: 0.60, brightness: 0.70),
        primaryForeground: Color(hue: 0.75, saturation: 0.30, brightness: 0.15),
        secondary: Color(hue: 0.056, saturation: 0.80, brightness: 0.92),
        secondaryForeground: Color(hue: 0.056, saturation: 0.60, brightness: 0.30),
        accent: Color(hue: 0.44, saturation: 0.50, brightness: 0.85),
        accentForeground: Color(hue: 0.44, saturation: 0.40, brightness: 0.25),
        muted: Color(hue: 0.75, saturation: 0.20, brightness: 0.94),
        mutedForeground: Color(hue: 0.75, saturation: 0.15, brightness: 0.50),
        destructive: Color(hue: 0.0, saturation: 0.65, brightness: 0.70),
        destructiveForeground: Color.white,
        border: Color(hue: 0.75, saturation: 0.30, brightness: 0.90),
        input: Color(hue: 0.75, saturation: 0.30, brightness: 0.92),
        bubbleGlow: Color(hue: 0.75, saturation: 0.50, brightness: 0.85)
    )
    
    static let dark = ThemeColors(
        background: Color(hue: 0.75, saturation: 0.30, brightness: 0.08),
        foreground: Color(hue: 0.75, saturation: 0.20, brightness: 0.95),
        card: Color(hue: 0.75, saturation: 0.25, brightness: 0.12),
        cardForeground: Color(hue: 0.75, saturation: 0.20, brightness: 0.95),
        primary: Color(hue: 0.75, saturation: 0.50, brightness: 0.65),
        primaryForeground: Color(hue: 0.75, saturation: 0.20, brightness: 0.95),
        secondary: Color(hue: 0.056, saturation: 0.60, brightness: 0.35),
        secondaryForeground: Color(hue: 0.056, saturation: 0.20, brightness: 0.95),
        accent: Color(hue: 0.44, saturation: 0.45, brightness: 0.55),
        accentForeground: Color(hue: 0.44, saturation: 0.20, brightness: 0.95),
        muted: Color(hue: 0.75, saturation: 0.20, brightness: 0.18),
        mutedForeground: Color(hue: 0.75, saturation: 0.15, brightness: 0.60),
        destructive: Color(hue: 0.0, saturation: 0.60, brightness: 0.60),
        destructiveForeground: Color.white,
        border: Color(hue: 0.75, saturation: 0.20, brightness: 0.20),
        input: Color(hue: 0.75, saturation: 0.25, brightness: 0.18),
        bubbleGlow: Color(hue: 0.75, saturation: 0.40, brightness: 0.35)
    )
    
    // MARK: - Emotion colors (scheme-independent)
    
    enum EmotionColor {
        static let sad = Color(hue: 0.611, saturation: 0.70, brightness: 0.75)
        static let angry = Color(hue: 0.0, saturation: 0.65, brightness: 0.72)
        static let confused = Color(hue: 0.125, saturation: 0.80, brightness: 0.75)
        static let hurt = Color(hue: 0.917, saturation: 0.60, brightness: 0.75)
        static let anxious = Color(hue: 0.778, saturation: 0.50, brightness: 0.75)
        static let disappointed = Color(hue: 0.556, saturation: 0.50, brightness: 0.70)
    }
    
    // MARK: - Person / avatar colors
    
    static let personColors: [Color] = [
        Color(hue: 0.75, saturation: 0.60, brightness: 0.70),
        Color(hue: 0.056, saturation: 0.80, brightness: 0.75),
        Color(hue: 0.44, saturation: 0.50, brightness: 0.70),
        Color(hue: 0.917, saturation: 0.60, brightness: 0.75),
        Color(hue: 0.556, saturation: 0.60, brightness: 0.70),
        Color(hue: 0.125, saturation: 0.80, brightness: 0.70),
    ]
    
    // MARK: - Gradients
    
    static var gradientY2K: LinearGradient {
        LinearGradient(
            colors: [
                Color(hue: 0.75, saturation: 0.70, brightness: 0.85),
                Color(hue: 0.889, saturation: 0.60, brightness: 0.88),
                Color(hue: 0.056, saturation: 0.70, brightness: 0.90)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static func gradientBubble(background: Color) -> LinearGradient {
        LinearGradient(
            colors: [
                background,
                Color(hue: 0.75, saturation: 0.80, brightness: 0.90).opacity(0.3)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct ThemeColors {
    let background: Color
    let foreground: Color
    let card: Color
    let cardForeground: Color
    let primary: Color
    let primaryForeground: Color
    let secondary: Color
    let secondaryForeground: Color
    let accent: Color
    let accentForeground: Color
    let muted: Color
    let mutedForeground: Color
    let destructive: Color
    let destructiveForeground: Color
    let border: Color
    let input: Color
    let bubbleGlow: Color
}

// MARK: - User-selectable accent

enum AccentColor: String, CaseIterable, Codable {
    case lavender
    case peach
    case mint
    case rose
    case sky
    
    var color: Color {
        switch self {
        case .lavender: return Color(hue: 0.75, saturation: 0.60, brightness: 0.70)
        case .peach: return Color(hue: 0.056, saturation: 0.80, brightness: 0.75)
        case .mint: return Color(hue: 0.44, saturation: 0.50, brightness: 0.70)
        case .rose: return Color(hue: 0.917, saturation: 0.60, brightness: 0.75)
        case .sky: return Color(hue: 0.556, saturation: 0.60, brightness: 0.70)
        }
    }
    
    var label: String { rawValue.capitalized }
}
