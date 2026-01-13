//
//  PersonRowView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct PersonRowView: View {
    let person: Person
    
    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(person.name)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.appText)
                        
                        Text(person.relationshipType.rawValue)
                            .font(.system(size: 14))
                            .foregroundColor(.appTextSecondary)
                    }
                    
                    Spacer()
                    
                    Text("\(person.strawCount) of \(person.threshold)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.appPrimary)
                }
                
                ProgressView(value: person.progress)
                    .tint(.appPrimary)
                    .scaleEffect(x: 1, y: 1.5, anchor: .center)
            }
        }
    }
}
