//
//  EmptyHomeView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct EmptyHomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.2.fill")
                .font(.system(size: 60))
                .foregroundColor(.appTextSecondary.opacity(0.5))
            
            Text(AppCopy.emptyHomeState)
                .font(.system(size: 16))
                .foregroundColor(.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}
