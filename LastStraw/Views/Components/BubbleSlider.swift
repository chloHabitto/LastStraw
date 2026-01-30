//
//  BubbleSlider.swift
//  LastStraw
//

import SwiftUI

struct BubbleSlider: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let label: String
    let helperFormat: String
    @Binding var value: Int
    var range: ClosedRange<Int> = 3...10
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var doubleValue: Binding<Double> {
        Binding(
            get: { Double(value) },
            set: { value = Int($0.rounded()) }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(label)
                .font(.body)
                .foregroundColor(theme.foreground)
            
            HStack(alignment: .center, spacing: 16) {
                Text("\(value)")
                    .font(.display(32, weight: .bold))
                    .foregroundColor(theme.primary)
                    .frame(minWidth: 44, alignment: .leading)
                
                Slider(
                    value: doubleValue,
                    in: Double(range.lowerBound)...Double(range.upperBound),
                    step: 1
                )
                .tint(theme.primary)
            }
            .padding(.vertical, 8)
            
            Text(String(format: helperFormat, value))
                .font(.footnote)
                .foregroundColor(theme.mutedForeground)
        }
    }
}

#Preview {
    BubbleSlider(
        label: "How many moments before taking stock?",
        helperFormat: "After %d moments, you'll get a gentle reminder to reflect.",
        value: .constant(5)
    )
    .padding()
    .background(Theme.colors(for: .light).background)
}
