//
//  SettingsViewModel.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

extension AppearanceMode {
    var colorScheme: ColorScheme? {
        switch self {
        case .auto:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
