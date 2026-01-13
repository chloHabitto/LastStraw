//
//  ProgressIndicatorView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct ProgressIndicatorView: View {
    let person: Person
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(person.strawCount) of \(person.threshold)")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.appText)
                
                Spacer()
                
                if person.hasReachedThreshold {
                    Text("Threshold Reached")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.appPrimary)
                }
            }
            
            ProgressView(value: person.progress)
                .tint(.appPrimary)
                .scaleEffect(x: 1, y: 2, anchor: .center)
        }
    }
}
