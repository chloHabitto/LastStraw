//
//  ArchivedPersonRowView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct ArchivedPersonRowView: View {
    let person: Person
    
    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: 8) {
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
                    
                    if let archivedAt = person.archivedAt {
                        Text(archivedAt.formatted(style: .medium))
                            .font(.system(size: 12))
                            .foregroundColor(.appTextSecondary)
                    }
                }
            }
        }
    }
}
