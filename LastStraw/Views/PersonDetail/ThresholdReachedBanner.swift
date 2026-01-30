//
//  ThresholdReachedBanner.swift
//  LastStraw
//

import SwiftUI

struct ThresholdReachedBanner: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    let onSitWithIt: () -> Void
    let onMakeDecision: () -> Void
    let onKeepObserving: () -> Void
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(AppCopy.thresholdReachedTitle)
                    .font(.display(18, weight: .semibold))
                    .foregroundColor(theme.foreground)
                Text(AppCopy.thresholdReachedSubtitle)
                    .font(.subheadline)
                    .foregroundColor(theme.mutedForeground)
            }
            VStack(spacing: 12) {
                Button("I want to sit with this more", action: onSitWithIt)
                    .buttonStyle(.bordered)
                    .tint(accent)
                Button("I'm ready to make a decision", action: onMakeDecision)
                    .buttonStyle(BubbleButtonStyle())
                Button(action: onKeepObserving) {
                    Text("I want to keep observing")
                        .font(.subheadline)
                        .foregroundColor(theme.mutedForeground)
                }
            }
        }
        .padding()
        .background(theme.secondary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.top, 8)
    }
}
