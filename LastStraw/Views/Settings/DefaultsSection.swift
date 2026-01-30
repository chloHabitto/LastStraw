//
//  DefaultsSection.swift
//  LastStraw
//

import SwiftUI

struct DefaultsSection: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        Section {
            HStack {
                Text("Default threshold")
                    .foregroundColor(theme.foreground)
                Spacer()
                Text("\(settings.defaultThreshold) moments")
                    .foregroundColor(theme.mutedForeground)
            }
            Slider(value: Binding(
                get: { Double(settings.defaultThreshold) },
                set: { settings.defaultThreshold = Int($0.rounded()) }
            ), in: 3...10, step: 1)
            .tint(theme.primary)
            NavigationLink {
                DefaultEmotionsView()
            } label: {
                Text("Default emotions")
                    .foregroundColor(theme.foreground)
            }
        } header: {
            Text("Defaults")
                .foregroundColor(theme.mutedForeground)
        }
    }
}

struct DefaultEmotionsView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        List {
            ForEach(Emotion.allCases, id: \.self) { emotion in
                let isSelected = settings.defaultEmotions.contains(emotion)
                Button(action: {
                    var current = settings.defaultEmotions
                    if isSelected {
                        current.removeAll { $0 == emotion }
                    } else {
                        current.append(emotion)
                    }
                    settings.defaultEmotions = current.isEmpty ? Emotion.allCases : current
                }) {
                    HStack {
                        Text(emotion.emoji)
                        Text(emotion.label)
                            .foregroundColor(theme.foreground)
                        Spacer()
                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(theme.primary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Default emotions")
        .navigationBarTitleDisplayMode(.inline)
    }
}
