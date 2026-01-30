//
//  PersonRowView.swift
//  LastStraw
//

import SwiftUI

struct PersonRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let person: Person
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        AppCard {
            HStack(spacing: 14) {
                Circle()
                    .fill(person.color)
                    .frame(width: 44, height: 44)
                    .overlay(
                        Text(person.initial)
                            .font(.display(18, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(person.name)
                        .font(.display(18, weight: .semibold))
                        .foregroundColor(theme.foreground)
                    
                    Text(person.relationship)
                        .font(.subheadline)
                        .foregroundColor(theme.mutedForeground)
                }
                
                Spacer()
                
                Text("\(person.strawCount)/\(person.threshold)")
                    .font(.display(16, weight: .medium))
                    .foregroundColor(accent)
            }
            .padding(.vertical, 4)
        }
    }
}
