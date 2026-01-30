//
//  Enums.swift
//  LastStraw
//

import SwiftUI

// MARK: - Relationship (optional quick-pick; stored as string on Person)

enum RelationshipType: String, Codable, CaseIterable {
    case romantic = "Romantic"
    case friend = "Friend"
    case family = "Family"
    case coworker = "Coworker"
    case other = "Other"
}

// MARK: - Emotion (single per straw)

enum Emotion: String, CaseIterable, Codable {
    case sad
    case angry
    case confused
    case hurt
    case anxious
    case disappointed
    
    var label: String {
        switch self {
        case .sad: return "Sad"
        case .angry: return "Frustrated"
        case .confused: return "Confused"
        case .hurt: return "Hurt"
        case .anxious: return "Anxious"
        case .disappointed: return "Let down"
        }
    }
    
    var emoji: String {
        switch self {
        case .sad: return "😢"
        case .angry: return "😤"
        case .confused: return "😕"
        case .hurt: return "💔"
        case .anxious: return "😰"
        case .disappointed: return "😞"
        }
    }
    
    var color: Color {
        switch self {
        case .sad: return Theme.EmotionColor.sad
        case .angry: return Theme.EmotionColor.angry
        case .confused: return Theme.EmotionColor.confused
        case .hurt: return Theme.EmotionColor.hurt
        case .anxious: return Theme.EmotionColor.anxious
        case .disappointed: return Theme.EmotionColor.disappointed
        }
    }
}

// MARK: - Bloom feeling

enum BloomFeeling: String, CaseIterable, Codable {
    case grateful
    case hopeful
    case loved
    case proud
    case peaceful
    case joyful
    
    var label: String { rawValue.capitalized }
    
    var emoji: String {
        switch self {
        case .grateful: return "🙏"
        case .hopeful: return "🌱"
        case .loved: return "💕"
        case .proud: return "✨"
        case .peaceful: return "☀️"
        case .joyful: return "🌸"
        }
    }
}

// MARK: - Threshold state

enum ThresholdState: String, Codable {
    case normal
    case observing
}

// MARK: - Appearance (Theme mode)

enum ThemeMode: String, CaseIterable, Codable {
    case auto
    case light
    case dark
    
    var label: String { rawValue.capitalized }
    
    var icon: String {
        switch self {
        case .auto: return "sparkles"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .auto: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
