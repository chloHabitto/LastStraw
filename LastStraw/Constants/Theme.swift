//
//  Theme.swift
//  LastStraw
//
//  Y2K-inspired soft bubble aesthetic.
//  Colors converted from CSS HSL to Swift HSB using proper formula.
//

import SwiftUI

// MARK: - HSL to HSB Conversion Helper

/// Converts HSL (Hue, Saturation, Lightness) to HSB (Hue, Saturation, Brightness)
/// - Parameters:
///   - h: Hue in degrees (0-360)
///   - s: Saturation as percentage (0-100)
///   - l: Lightness as percentage (0-100)
/// - Returns: SwiftUI Color
private func colorFromHSL(h: Double, s: Double, l: Double) -> Color {
    let hNorm = h / 360.0
    let sNorm = s / 100.0
    let lNorm = l / 100.0
    
    // HSL to HSB conversion
    let b = lNorm + sNorm * min(lNorm, 1 - lNorm)
    let sHSB = b > 0 ? 2 * (1 - lNorm / b) : 0
    
    return Color(hue: hNorm, saturation: sHSB, brightness: b)
}

// MARK: - Theme Colors (light/dark)

struct Theme {
    
    /// Returns semantic colors for the given color scheme.
    static func colors(for colorScheme: ColorScheme) -> ThemeColors {
        colorScheme == .dark ? dark : light
    }
    
    // MARK: Light Mode
    // CSS values from src/index.css :root
    
    static let light = ThemeColors(
        // --background: 270 50% 98%
        background: colorFromHSL(h: 270, s: 50, l: 98),
        // --foreground: 270 30% 25%
        foreground: colorFromHSL(h: 270, s: 30, l: 25),
        // --card: 0 0% 100% (white)
        card: Color.white,
        // --card-foreground: 270 30% 25%
        cardForeground: colorFromHSL(h: 270, s: 30, l: 25),
        // --primary: 270 60% 70%
        primary: colorFromHSL(h: 270, s: 60, l: 70),
        // --primary-foreground: 270 30% 15%
        primaryForeground: colorFromHSL(h: 270, s: 30, l: 15),
        // --secondary: 20 80% 92%
        secondary: colorFromHSL(h: 20, s: 80, l: 92),
        // --secondary-foreground: 20 60% 30%
        secondaryForeground: colorFromHSL(h: 20, s: 60, l: 30),
        // --accent: 160 50% 85%
        accent: colorFromHSL(h: 160, s: 50, l: 85),
        // --accent-foreground: 160 40% 25%
        accentForeground: colorFromHSL(h: 160, s: 40, l: 25),
        // --muted: 270 20% 94%
        muted: colorFromHSL(h: 270, s: 20, l: 94),
        // --muted-foreground: 270 15% 50%
        mutedForeground: colorFromHSL(h: 270, s: 15, l: 50),
        // --destructive: 0 65% 70%
        destructive: colorFromHSL(h: 0, s: 65, l: 70),
        // --destructive-foreground: 0 0% 100%
        destructiveForeground: Color.white,
        // --border: 270 30% 90%
        border: colorFromHSL(h: 270, s: 30, l: 90),
        // --input: 270 30% 92%
        input: colorFromHSL(h: 270, s: 30, l: 92),
        // --bubble-glow: 270 80% 90%
        bubbleGlow: colorFromHSL(h: 270, s: 80, l: 90)
    )
    
    // MARK: Dark Mode
    // CSS values from src/index.css .dark
    
    static let dark = ThemeColors(
        // --background: 270 30% 8%
        background: colorFromHSL(h: 270, s: 30, l: 8),
        // --foreground: 270 20% 95%
        foreground: colorFromHSL(h: 270, s: 20, l: 95),
        // --card: 270 25% 12%
        card: colorFromHSL(h: 270, s: 25, l: 12),
        // --card-foreground: 270 20% 95%
        cardForeground: colorFromHSL(h: 270, s: 20, l: 95),
        // --primary: 270 50% 65%
        primary: colorFromHSL(h: 270, s: 50, l: 65),
        // --primary-foreground: 270 30% 10%
        primaryForeground: colorFromHSL(h: 270, s: 30, l: 10),
        // --secondary: 20 40% 20%
        secondary: colorFromHSL(h: 20, s: 40, l: 20),
        // --secondary-foreground: 20 60% 90%
        secondaryForeground: colorFromHSL(h: 20, s: 60, l: 90),
        // --accent: 160 30% 25%
        accent: colorFromHSL(h: 160, s: 30, l: 25),
        // --accent-foreground: 160 40% 90%
        accentForeground: colorFromHSL(h: 160, s: 40, l: 90),
        // --muted: 270 20% 18%
        muted: colorFromHSL(h: 270, s: 20, l: 18),
        // --muted-foreground: 270 15% 60%
        mutedForeground: colorFromHSL(h: 270, s: 15, l: 60),
        // --destructive: 0 50% 40%
        destructive: colorFromHSL(h: 0, s: 50, l: 40),
        // --destructive-foreground: 0 0% 100%
        destructiveForeground: Color.white,
        // --border: 270 20% 20%
        border: colorFromHSL(h: 270, s: 20, l: 20),
        // --input: 270 20% 20%
        input: colorFromHSL(h: 270, s: 20, l: 20),
        // --bubble-glow: 270 50% 30%
        bubbleGlow: colorFromHSL(h: 270, s: 50, l: 30)
    )
    
    // MARK: - Emotion colors (from CSS --emotion-* variables)
    
    enum EmotionColor {
        // --emotion-sad: 220 70% 75%
        static let sad = colorFromHSL(h: 220, s: 70, l: 75)
        // --emotion-angry: 0 65% 72%
        static let angry = colorFromHSL(h: 0, s: 65, l: 72)
        // --emotion-confused: 45 80% 75%
        static let confused = colorFromHSL(h: 45, s: 80, l: 75)
        // --emotion-hurt: 330 60% 75%
        static let hurt = colorFromHSL(h: 330, s: 60, l: 75)
        // --emotion-anxious: 280 50% 75%
        static let anxious = colorFromHSL(h: 280, s: 50, l: 75)
        // --emotion-disappointed: 200 50% 70%
        static let disappointed = colorFromHSL(h: 200, s: 50, l: 70)
    }
    
    // MARK: - Person / avatar colors
    
    static let personColors: [Color] = [
        colorFromHSL(h: 270, s: 60, l: 70),  // Lavender
        colorFromHSL(h: 20, s: 80, l: 75),   // Peach
        colorFromHSL(h: 160, s: 50, l: 70),  // Mint
        colorFromHSL(h: 330, s: 60, l: 75),  // Rose
        colorFromHSL(h: 200, s: 60, l: 70),  // Sky
        colorFromHSL(h: 45, s: 80, l: 70),   // Gold
    ]
    
    // MARK: - Gradients
    // CSS gradient stops from src/index.css
    
    static var gradientY2K: LinearGradient {
        LinearGradient(
            colors: [
                // --gradient-start: 270 70% 85%
                colorFromHSL(h: 270, s: 70, l: 85),
                // --gradient-mid: 320 60% 88%
                colorFromHSL(h: 320, s: 60, l: 88),
                // --gradient-end: 20 70% 90%
                colorFromHSL(h: 20, s: 70, l: 90)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static func gradientBubble(background: Color) -> LinearGradient {
        LinearGradient(
            colors: [
                background,
                // --bubble-glow: 270 80% 90% with 0.3 opacity
                colorFromHSL(h: 270, s: 80, l: 90).opacity(0.3)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - ThemeColors struct

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

// MARK: - User-selectable accent colors
// From src/hooks/useSettings.ts ACCENT_COLORS

enum AccentColor: String, CaseIterable, Codable {
    case lavender
    case peach
    case mint
    case rose
    case sky
    
    var color: Color {
        switch self {
        // { value: 'lavender', hsl: '270 60% 70%' }
        case .lavender: return colorFromHSL(h: 270, s: 60, l: 70)
        // { value: 'peach', hsl: '20 80% 75%' }
        case .peach: return colorFromHSL(h: 20, s: 80, l: 75)
        // { value: 'mint', hsl: '160 50% 70%' }
        case .mint: return colorFromHSL(h: 160, s: 50, l: 70)
        // { value: 'rose', hsl: '330 60% 75%' }
        case .rose: return colorFromHSL(h: 330, s: 60, l: 75)
        // { value: 'sky', hsl: '200 60% 70%' }
        case .sky: return colorFromHSL(h: 200, s: 60, l: 70)
        }
    }
    
    var label: String { rawValue.capitalized }
}
