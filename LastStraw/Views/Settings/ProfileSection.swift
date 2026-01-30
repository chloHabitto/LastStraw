//
//  ProfileSection.swift
//  LastStraw
//

import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("userName") private var userName: String = ""
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    SettingsSection(title: "Your Profile") {
                        VStack(spacing: 16) {
                            // Avatar circle
                            Circle()
                                .fill(theme.primary.opacity(0.2))
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Group {
                                        if let firstChar = userName.first {
                                            Text(String(firstChar).uppercased())
                                                .font(.display(32, weight: .bold))
                                                .foregroundColor(theme.primary)
                                        } else {
                                            Image(systemName: "person.fill")
                                                .font(.system(size: 32))
                                                .foregroundColor(theme.primary)
                                        }
                                    }
                                )
                            
                            // Name input
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Your name (optional)")
                                    .font(.system(size: 13))
                                    .foregroundColor(theme.mutedForeground)
                                TextField("How should we greet you?", text: $userName)
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    // Footer note
                    Text("💜 This is just for you. Your name stays on your device.")
                        .font(.system(size: 13))
                        .foregroundColor(theme.mutedForeground)
                        .padding(.horizontal, 4)
                }
                .padding(20)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ProfileDetailView()
            .environmentObject(AppSettings())
    }
}
