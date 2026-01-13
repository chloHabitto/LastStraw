//
//  AppButton.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct AppButton: View {
    let title: String
    let action: () -> Void
    var style: ButtonStyle = .primary
    var isDisabled: Bool = false
    
    enum ButtonStyle {
        case primary
        case secondary
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(style == .primary ? .white : .appPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    style == .primary ? Color.appPrimary : Color.clear
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style == .primary ? Color.clear : Color.appPrimary, lineWidth: 2)
                )
                .cornerRadius(12)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1.0)
    }
}
