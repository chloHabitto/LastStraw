//
//  SettingsView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("appearanceMode") private var appearanceModeRawValue: String = AppearanceMode.auto.rawValue
    
    private var appearanceMode: Binding<AppearanceMode> {
        Binding(
            get: {
                AppearanceMode(rawValue: appearanceModeRawValue) ?? .auto
            },
            set: {
                appearanceModeRawValue = $0.rawValue
            }
        )
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        AppCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Appearance")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.appText)
                                
                                Picker("Appearance Mode", selection: appearanceMode) {
                                    ForEach(AppearanceMode.allCases, id: \.self) { mode in
                                        Text(mode.rawValue).tag(mode)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
