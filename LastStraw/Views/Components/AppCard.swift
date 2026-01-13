//
//  AppCard.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct AppCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(Color.appCardBackground)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
    }
}
