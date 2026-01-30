//
//  ProgressIndicatorView.swift
//  LastStraw
//

import SwiftUI

struct ProgressIndicatorView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let person: Person
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("\(person.strawCount) of \(person.threshold)")
                    .font(.display(18, weight: .semibold))
                    .foregroundColor(theme.foreground)
                Spacer()
                if person.hasReachedThreshold {
                    Text("Threshold Reached")
                        .font(.display(14, weight: .medium))
                        .foregroundColor(accent)
                }
            }
            ThresholdDotsView(person: person)
        }
    }
}
