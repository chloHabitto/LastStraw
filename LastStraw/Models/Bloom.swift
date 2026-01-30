//
//  Bloom.swift
//  LastStraw
//

import Foundation
import SwiftData

@Model
final class Bloom {
    var id: UUID = UUID()
    var feeling: BloomFeeling = BloomFeeling.grateful
    var note: String = ""
    var date: Date = Date()
    var person: Person?

    init(feeling: BloomFeeling, note: String, date: Date = Date()) {
        self.id = UUID()
        self.feeling = feeling
        self.note = note
        self.date = date
    }
}
