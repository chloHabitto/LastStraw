//
//  AppButton.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct AppButton: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    let action: () -> Void
    var style: ButtonStyle = .primary
    var isDisabled: Bool = false
    
    enum ButtonStyle {
        case primary
        case secondary
    }
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(style == .primary ? theme.primaryForeground : theme.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    style == .primary ? theme.primary : Color.clear
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style == .primary ? Color.clear : theme.primary, lineWidth: 2)
                )
                .cornerRadius(12)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1.0)
    }
}
