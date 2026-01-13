//
//  Person.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import Foundation
import SwiftData

@Model
final class Person {
    var id: UUID
    var name: String
    var relationshipType: RelationshipType
    var threshold: Int
    var createdAt: Date
    var isArchived: Bool
    var archiveReflection: String?
    var archiveDecision: String?
    var archivedAt: Date?
    
    @Relationship(deleteRule: .cascade, inverse: \Straw.person)
    var straws: [Straw]
    
    init(name: String, relationshipType: RelationshipType, threshold: Int) {
        self.id = UUID()
        self.name = name
        self.relationshipType = relationshipType
        self.threshold = threshold
        self.createdAt = Date()
        self.isArchived = false
        self.straws = []
    }
    
    var strawCount: Int {
        straws.count
    }
    
    var hasReachedThreshold: Bool {
        strawCount >= threshold
    }
    
    var progress: Double {
        guard threshold > 0 else { return 0 }
        return min(Double(strawCount) / Double(threshold), 1.0)
    }
}
