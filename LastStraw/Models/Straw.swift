//
//  Straw.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import Foundation
import SwiftData

@Model
final class Straw {
    var id: UUID
    var whatHappened: String
    var howIFelt: String
    var emotionTags: [EmotionTag]
    var createdAt: Date
    var person: Person?
    
    init(whatHappened: String, howIFelt: String, emotionTags: [EmotionTag] = []) {
        self.id = UUID()
        self.whatHappened = whatHappened
        self.howIFelt = howIFelt
        self.emotionTags = emotionTags
        self.createdAt = Date()
    }
}
