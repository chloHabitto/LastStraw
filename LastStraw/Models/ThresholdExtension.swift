//
//  ThresholdExtension.swift
//  LastStraw
//

import Foundation
import SwiftData

@Model
final class ThresholdExtension {
    var id: UUID
    var amount: Int
    var date: Date
    var previousThreshold: Int
    var person: Person?
    
    init(amount: Int, date: Date = Date(), previousThreshold: Int) {
        self.id = UUID()
        self.amount = amount
        self.date = date
        self.previousThreshold = previousThreshold
    }
}
