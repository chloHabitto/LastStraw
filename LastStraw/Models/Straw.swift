//
//  Straw.swift
//  LastStraw
//

import Foundation
import SwiftData

@Model
final class Straw {
    var id: UUID = UUID()
    var emotion: Emotion = Emotion.sad
    var note: String = ""
    var date: Date = Date()
    var person: Person?

    init(emotion: Emotion, note: String, date: Date = Date()) {
        self.id = UUID()
        self.emotion = emotion
        self.note = note
        self.date = date
    }
}
