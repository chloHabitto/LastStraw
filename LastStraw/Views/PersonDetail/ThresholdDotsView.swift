//
//  ThresholdDotsView.swift
//  LastStraw
//

import SwiftUI

struct ThresholdDotsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let person: Person
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        HStack(spacing: 8) {
            if person.thresholdState == .observing {
                Image(systemName: "eye.fill")
                    .font(.title3)
                    .foregroundColor(theme.mutedForeground)
                Text("Observing")
                    .font(.display(14))
                    .foregroundColor(theme.mutedForeground)
            } else {
                ForEach(0..<person.threshold, id: \.self) { index in
                    Circle()
                        .fill(index < person.strawCount ? accent : theme.muted)
                        .frame(width: 12, height: 12)
                }
            }
        }
    }
}
