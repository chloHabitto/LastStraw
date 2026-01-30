//
//  NotificationsSection.swift
//  LastStraw
//

import SwiftUI

struct NotificationsSection: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        Section {
            Toggle("Reminders", isOn: $settings.remindersEnabled)
                .foregroundColor(theme.foreground)
            if settings.remindersEnabled {
                Picker("Frequency", selection: $settings.reminderFrequency) {
                    ForEach(ReminderFrequency.allCases, id: \.self) { freq in
                        Text(freq.label).tag(freq)
                    }
                }
                .foregroundColor(theme.foreground)
                Picker("Tone", selection: $settings.reminderTone) {
                    ForEach(ReminderTone.allCases, id: \.self) { tone in
                        Text(tone.label).tag(tone)
                    }
                }
                .foregroundColor(theme.foreground)
            }
        } header: {
            Text("Notifications")
                .foregroundColor(theme.mutedForeground)
        }
    }
}
