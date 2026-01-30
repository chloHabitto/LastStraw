//
//  BubbleTextField.swift
//  LastStraw
//

import SwiftUI

struct BubbleTextField: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let label: String
    let placeholder: String
    @Binding var text: String
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.body)
                .foregroundColor(theme.foreground)
            
            TextField(placeholder, text: $text)
                .font(.body)
                .padding(.horizontal, 16)
                .frame(height: 48)
                .background(theme.input)
                .clipShape(RoundedRectangle(cornerRadius: 32))
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
