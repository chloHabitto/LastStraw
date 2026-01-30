//
//  Bloom.swift
//  LastStraw
//

import Foundation
import SwiftData

@Model
final class Bloom {
    var id: UUID
    var feeling: BloomFeeling
    var note: String
    var date: Date
    var person: Person?
    
    init(feeling: BloomFeeling, note: String, date: Date = Date()) {
        self.id = UUID()
        self.feeling = feeling
        self.note = note
        self.date = date
    }
}
