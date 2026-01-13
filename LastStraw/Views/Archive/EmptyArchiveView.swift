//
//  EmptyArchiveView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct EmptyArchiveView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "archivebox.fill")
                .font(.system(size: 60))
                .foregroundColor(.appTextSecondary.opacity(0.5))
            
            Text(AppCopy.emptyArchiveState)
                .font(.system(size: 16))
                .foregroundColor(.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}
