//
//  StrawRowView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct StrawRowView: View {
    let straw: Straw
    @State private var isExpanded = false
    
    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(straw.createdAt.formatted(style: .medium))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.appTextSecondary)
                    
                    Spacer()
                    
                    Button(action: { isExpanded.toggle() }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.appTextSecondary)
                    }
                }
                
                Text(straw.whatHappened)
                    .font(.system(size: 16))
                    .foregroundColor(.appText)
                    .lineLimit(isExpanded ? nil : 2)
                
                if isExpanded {
                    if !straw.howIFelt.isEmpty {
                        Text(straw.howIFelt)
                            .font(.system(size: 15))
                            .foregroundColor(.appTextSecondary)
                            .padding(.top, 4)
                    }
                    
                    if !straw.emotionTags.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(straw.emotionTags, id: \.self) { tag in
                                    Text(tag.rawValue)
                                        .font(.system(size: 12))
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(Color.appPrimary.opacity(0.15))
                                        .foregroundColor(.appPrimary)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.top, 8)
                    }
                }
            }
        }
    }
}
