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
                    Image(systemName: "archivebox.fill")
                        .font(.system(size: 36))
                        .foregroundColor(theme.mutedForeground)
                )
            Text(AppCopy.emptyArchiveState)
                .font(.body)
                .foregroundColor(theme.mutedForeground)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}
