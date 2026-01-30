//
//  AppSettings.swift
//  LastStraw
//

import SwiftUI
import Combine

enum ReminderFrequency: String, CaseIterable, Codable {
    case never
    case weekly
    case custom
    
    var label: String { rawValue.capitalized }
}

enum ReminderTone: String, CaseIterable, Codable {
    case encouraging
    case neutral
    
    var label: String { rawValue.capitalized }
}

final class AppSettings: ObservableObject {
    @Published private(set) var didChange = false
    @AppStorage("themeMode") var themeMode: ThemeMode = .auto
    @AppStorage("accentColor") var accentColor: AccentColor = .lavender
    @AppStorage("remindersEnabled") var remindersEnabled: Bool = false
    @AppStorage("reminderFrequency") var reminderFrequency: ReminderFrequency = .never
    @AppStorage("reminderTone") var reminderTone: ReminderTone = .encouraging
    @AppStorage("requirePasscode") var requirePasscode: Bool = false
    @AppStorage("hideAppPreview") var hideAppPreview: Bool = false
    @AppStorage("disguiseIcon") var disguiseIcon: Bool = false
    @AppStorage("defaultThreshold") var defaultThreshold: Int = 5
    @AppStorage("defaultEmotions") var defaultEmotionsData: Data = Data()
    
    var defaultEmotions: [Emotion] {
        get {
            (try? JSONDecoder().decode([Emotion].self, from: defaultEmotionsData)) ?? Emotion.allCases
        }
        set {
            defaultEmotionsData = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }
}
