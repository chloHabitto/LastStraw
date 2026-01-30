//
//  EmptyArchiveView.swift
//  LastStraw
//

import SwiftUI

struct EmptyArchiveView: View {
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }

    var body: some View {
        VStack(spacing: 24) {
            Circle()
                .fill(theme.muted)
                .frame(width: 80, height: 80)
                .overlay(
                    Text("📦")
                        .font(.system(size: 48))
                )
            Text(AppCopy.emptyArchiveState)
                .font(.body)
                .foregroundColor(theme.mutedForeground)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 40)
    }
}
