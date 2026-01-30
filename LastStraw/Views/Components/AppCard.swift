//
//  AppCard.swift
//  LastStraw
//

import SwiftUI

struct AppCard<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .modifier(BubbleCard())
    }
}
