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
        HStack(alignment: .top, spacing: 12) {
            // Icon in circle container
            Circle()
                .fill(theme.muted)
                .frame(width: 32, height: 32)
                .overlay(
                    Image(systemName: "clock.fill")
                        .font(.system(size: 14))
                        .foregroundColor(theme.mutedForeground)
                )
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Extended threshold by +\(extensionItem.amount)")
                        .font(.subheadline)
                        .foregroundColor(theme.mutedForeground)
                    
                    Spacer()
                    
                    Text(extensionItem.date.relativeString())
                        .font(.caption)
                        .foregroundColor(theme.mutedForeground)
                }
                
                // Show the transition
                Text("\(extensionItem.previousThreshold) → \(extensionItem.previousThreshold + extensionItem.amount)")
                    .font(.caption)
                    .foregroundColor(theme.mutedForeground.opacity(0.7))
            }
        }
        .padding(16)
        .background(theme.muted.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
