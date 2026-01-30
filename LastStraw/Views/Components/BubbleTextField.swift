//
//  BubbleTextField.swift
//  LastStraw
//

import SwiftUI

struct BubbleTextField: View {
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isFocused: Bool
    
    let label: String
    let placeholder: String
    @Binding var text: String
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !label.isEmpty {
                Text(label)
                    .font(.body)
                    .foregroundColor(theme.foreground)
            }
            
            TextField(placeholder, text: $text)
                .font(.body)
                .padding(.horizontal, 16)
                .frame(height: 48)
                .background(theme.input)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(isFocused ? theme.primary : Color.clear, lineWidth: 2)
                )
                .focused($isFocused)
                .animation(.easeInOut(duration: 0.15), value: isFocused)
        }
    }
}

#Preview {
    BubbleTextField(
        label: "Their name",
        placeholder: "First name or nickname",
        text: .constant("")
    )
    .padding()
    .background(Theme.colors(for: .light).background)
}
