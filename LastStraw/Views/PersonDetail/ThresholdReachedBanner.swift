//
//  ThresholdReachedBanner.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct ThresholdReachedBanner: View {
    let onSitWithIt: () -> Void
    let onMakeDecision: () -> Void
    let onKeepObserving: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(AppCopy.thresholdReachedTitle)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.appText)
                
                Text(AppCopy.thresholdReachedSubtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.appTextSecondary)
            }
            
            VStack(spacing: 12) {
                AppButton(title: "I want to sit with this more", action: { onSitWithIt() }, style: .secondary)
                
                AppButton(title: "I'm ready to make a decision", action: { onMakeDecision() }, style: .primary)
                
                Button(action: onKeepObserving) {
                    Text("I want to keep observing")
                        .font(.system(size: 14))
                        .foregroundColor(.appTextSecondary)
                }
            }
        }
        .padding()
        .background(Color.appSecondary.opacity(0.1))
        .cornerRadius(12)
        .padding(.top, 8)
    }
}
