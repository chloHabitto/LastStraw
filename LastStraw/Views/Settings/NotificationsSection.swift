//
//  NotificationsSection.swift
//  LastStraw
//

import SwiftUI

/// Detail page for notifications: pill segmented controls for frequency/tone and toggle for reminders.
struct NotificationsDetailView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SettingsSection(title: "Reminders") {
                        SettingsRow(icon: "bell.fill", label: "Reminders", description: "Daily check-in", trailing: { Toggle("", isOn: $settings.remindersEnabled).labelsHidden().tint(theme.primary) })
                    }
                    
                    if settings.remindersEnabled {
                        SettingsSection(title: "Frequency") {
                            HStack(spacing: 8) {
                                ForEach(ReminderFrequency.allCases, id: \.self) { freq in
                                    pillButton(title: freq.label, isActive: settings.reminderFrequency == freq) {
                                        settings.reminderFrequency = freq
                                    }
                                }
                            }
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 24).fill(theme.muted))
                        }
                        
                        SettingsSection(title: "Tone") {
                            HStack(spacing: 8) {
                                ForEach(ReminderTone.allCases, id: \.self) { tone in
                                    pillButton(title: tone.label, isActive: settings.reminderTone == tone) {
                                        settings.reminderTone = tone
                                    }
                                }
                            }
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 24).fill(theme.muted))
                        }
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func pillButton(title: String, isActive: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isActive ? theme.foreground : theme.mutedForeground)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 20).fill(isActive ? theme.card : Color.clear))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(theme.border.opacity(isActive ? 0.5 : 0.3), lineWidth: 1))
                .shadow(color: isActive ? theme.primary.opacity(0.08) : .clear, radius: 6, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        NotificationsDetailView()
            .environmentObject(AppSettings())
    }
}
