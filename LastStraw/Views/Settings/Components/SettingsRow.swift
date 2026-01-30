//
//  SettingsRow.swift
//  LastStraw
//

import SwiftUI

/// Detail page row: optional icon, label, optional description, trailing content (controls/toggles/chevron), destructive style support.
struct SettingsRow<Trailing: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let icon: String?
    let label: String
    let description: String?
    let isDestructive: Bool
    let showChevron: Bool
    @ViewBuilder let trailing: () -> Trailing
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    init(
        icon: String? = nil,
        label: String,
        description: String? = nil,
        isDestructive: Bool = false,
        showChevron: Bool = false,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.icon = icon
        self.label = label
        self.description = description
        self.isDestructive = isDestructive
        self.showChevron = showChevron
        self.trailing = trailing
    }
    
    var body: some View {
        HStack(spacing: 12) {
            if let icon {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isDestructive ? theme.destructive.opacity(0.15) : theme.primary.opacity(0.1))
                        .frame(width: 36, height: 36)
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(isDestructive ? theme.destructive : theme.primary)
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isDestructive ? theme.destructive : theme.foreground)
                if let description {
                    Text(description)
                        .font(.system(size: 12))
                        .foregroundColor(theme.mutedForeground)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            trailing()
            
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(theme.mutedForeground)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

extension SettingsRow where Trailing == EmptyView {
    init(
        icon: String? = nil,
        label: String,
        description: String? = nil,
        isDestructive: Bool = false,
        showChevron: Bool = false
    ) {
        self.icon = icon
        self.label = label
        self.description = description
        self.isDestructive = isDestructive
        self.showChevron = showChevron
        self.trailing = { EmptyView() }
    }
}

#Preview {
    VStack {
        SettingsRow(icon: "bell.fill", label: "Reminders", description: "Daily check-in", trailing: { Toggle("", isOn: .constant(true)).labelsHidden() })
        SettingsRow(label: "Version", trailing: { Text("1.0").foregroundColor(Theme.colors(for: .light).mutedForeground) })
    }
    .padding()
    .background(Theme.colors(for: .light).card)
}
