//
//  ThresholdExtensionRowView.swift
//  LastStraw
//

import SwiftUI

struct ThresholdExtensionRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    let extensionItem: ThresholdExtension
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        AppCard {
            HStack(spacing: 12) {
                Image(systemName: "clock.badge.plus")
                    .font(.title3)
                    .foregroundColor(theme.mutedForeground)
                Text("+\(extensionItem.amount) moments")
                    .font(.display(14, weight: .medium))
                    .foregroundColor(theme.foreground)
                Spacer()
                Text(extensionItem.date.relativeString())
                    .font(.caption)
                    .foregroundColor(theme.mutedForeground)
            }
        }
    }
}
