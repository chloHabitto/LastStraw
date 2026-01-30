//
//  Person.swift
//  LastStraw
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Person {
    var id: UUID
    var name: String
    var relationship: String
    var threshold: Int
    var createdAt: Date
    var isArchived: Bool
    var archivedAt: Date?
    /// Optional for migration: existing records created before this field have nil; use safeColorIndex for display.
    var colorIndex: Int?
    var thresholdState: ThresholdState

    var safeColorIndex: Int { colorIndex ?? 0 }
    
    @Relationship(deleteRule: .cascade, inverse: \Straw.person)
    var straws: [Straw]
    
    @Relationship(deleteRule: .cascade, inverse: \Bloom.person)
    var blooms: [Bloom]
    
    @Relationship(deleteRule: .cascade, inverse: \ThresholdExtension.person)
    var thresholdExtensions: [ThresholdExtension]
    
    init(name: String, relationship: String, threshold: Int, colorIndex: Int = 0) {
        self.id = UUID()
        self.name = name
        self.relationship = relationship
        self.threshold = threshold
        self.createdAt = Date()
        self.isArchived = false
        self.archivedAt = nil
        self.colorIndex = colorIndex
        self.thresholdState = .normal
        self.straws = []
        self.blooms = []
        self.thresholdExtensions = []
    }
    
    var color: Color {
        Theme.personColors[safeColorIndex % Theme.personColors.count]
    }
    
    var initial: String {
        String(name.prefix(1)).uppercased()
    }
    
    var strawCount: Int { straws.count }
    
    var hasReachedThreshold: Bool { strawCount >= threshold }
    
    var progress: Double {
        guard threshold > 0 else { return 0 }
        return min(Double(strawCount) / Double(threshold), 1.0)
    }
}
