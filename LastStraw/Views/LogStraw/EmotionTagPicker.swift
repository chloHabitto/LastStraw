//
//  EmotionTagPicker.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct EmotionTagPicker: View {
    @Binding var selectedEmotions: Set<EmotionTag>
    
    private let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 12)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(EmotionTag.allCases, id: \.self) { emotion in
                Button(action: {
                    if selectedEmotions.contains(emotion) {
                        selectedEmotions.remove(emotion)
                    } else {
                        selectedEmotions.insert(emotion)
                    }
                }) {
                    Text(emotion.rawValue)
                        .font(.system(size: 14))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            selectedEmotions.contains(emotion) ?
                            Color.appPrimary : Color.appTextSecondary.opacity(0.1)
                        )
                        .foregroundColor(
                            selectedEmotions.contains(emotion) ?
                            .white : .appText
                        )
                        .cornerRadius(8)
                }
            }
        }
    }
}
