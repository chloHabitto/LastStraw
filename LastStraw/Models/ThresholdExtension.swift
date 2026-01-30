//
//  ThresholdExtension.swift
//  LastStraw
//

import Foundation
import SwiftData

@Model
final class ThresholdExtension {
    var id: UUID = UUID()
    var amount: Int = 0
    var date: Date = Date()
    var previousThreshold: Int = 0
    var person: Person?

    init(amount: Int, date: Date = Date(), previousThreshold: Int) {
        self.id = UUID()
        self.amount = amount
        self.date = date
        self.previousThreshold = previousThreshold
    }
}
