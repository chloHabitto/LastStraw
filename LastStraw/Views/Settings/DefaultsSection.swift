//
//  DefaultsSection.swift
//  LastStraw
//

import SwiftUI

/// Detail page for defaults: threshold slider and navigation to default emotions.
struct DefaultsDetailView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SettingsSection(title: "Default threshold") {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("\(settings.defaultThreshold) moments")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(theme.foreground)
                                Spacer()
                            }
                            Slider(
                                value: Binding(
                                    get: { Double(settings.defaultThreshold) },
                                    set: { settings.defaultThreshold = Int($0.rounded()) }
                                ),
                                in: 3...10,
                                step: 1
                            )
                            .tint(theme.primary)
                        }
                    }
                    
                    SettingsSection(title: "Default emotions") {
                        NavigationLink {
                            DefaultEmotionsView()
                        } label: {
                            SettingsRow(icon: "face.smiling.fill", label: "Default emotions", description: "Choose emotions for new straws", showChevron: true)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Defaults")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

struct DefaultEmotionsView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SettingsSection(title: "Emotions") {
                        VStack(spacing: 0) {
                            ForEach(Array(Emotion.allCases.enumerated()), id: \.element) { index, emotion in
                                let isSelected = settings.defaultEmotions.contains(emotion)
                                Button {
                                    var current = settings.defaultEmotions
                                    if isSelected {
                                        current.removeAll { $0 == emotion }
                                    } else {
                                        current.append(emotion)
                                    }
                                    settings.defaultEmotions = current.isEmpty ? Emotion.allCases : current
                                } label: {
                                    HStack(spacing: 12) {
                                        Text(emotion.emoji)
                                            .font(.system(size: 20))
                                        Text(emotion.label)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(theme.foreground)
                                        Spacer()
                                        if isSelected {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(theme.primary)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                }
                                .buttonStyle(.plain)
                                if index < Emotion.allCases.count - 1 {
                                    Rectangle()
                                        .fill(theme.border.opacity(0.3))
                                        .frame(height: 1)
                                        .padding(.leading, 16 + 12 + 40)
                                }
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Default emotions")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        DefaultsDetailView()
            .environmentObject(AppSettings())
    }
}
