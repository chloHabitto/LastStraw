//
//  EmptyHomeView.swift
//  LastStraw
//

import SwiftUI

struct EmptyHomeView: View {
    @Environment(\.colorScheme) private var colorScheme
    var onAddPerson: (() -> Void)?
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        VStack(spacing: 24) {
            Circle()
                .fill(theme.muted)
                .frame(width: 80, height: 80)
                .overlay(
                    Text("👋")
                        .font(.system(size: 40))
                )
            
            Text(AppCopy.emptyHomeState)
                .font(.body)
                .foregroundColor(theme.mutedForeground)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Text(AppCopy.emptyHomeTagline)
                .font(.subheadline)
                .foregroundColor(theme.mutedForeground)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            if let onAddPerson {
                Button("Add your first person", action: onAddPerson)
                    .buttonStyle(BubbleButtonStyle())
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}
