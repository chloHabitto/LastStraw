//
//  Enums.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import Foundation

enum RelationshipType: String, Codable, CaseIterable {
    case romantic = "Romantic"
    case friend = "Friend"
    case family = "Family"
    case coworker = "Coworker"
    case other = "Other"
}

enum EmotionTag: String, Codable, CaseIterable {
    case dismissed = "Dismissed"
    case disrespected = "Disrespected"
    case confused = "Confused"
    case hurt = "Hurt"
    case angry = "Angry"
    case invisible = "Invisible"
    case anxious = "Anxious"
    case exhausted = "Exhausted"
    case gaslit = "Gaslit"
    case sad = "Sad"
}
