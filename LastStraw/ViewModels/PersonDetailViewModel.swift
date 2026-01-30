//
//  PersonDetailViewModel.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import Foundation
import SwiftData

@Observable
class PersonDetailViewModel {
    var person: Person
    var modelContext: ModelContext
    
    init(person: Person, modelContext: ModelContext) {
        self.person = person
        self.modelContext = modelContext
    }
    
    var sortedStraws: [Straw] {
        person.straws.sorted { $0.date > $1.date }
    }
    
    func addStraw(_ straw: Straw) {
        straw.person = person
        person.straws.append(straw)
        do {
            try modelContext.save()
        } catch {
            print("Error adding straw: \(error)")
        }
    }
    
    func archivePerson() {
        person.isArchived = true
        person.archivedAt = Date()
        do {
            try modelContext.save()
        } catch {
            print("Error archiving person: \(error)")
        }
    }
    
    func increaseThreshold(by amount: Int) {
        person.threshold += amount
        do {
            try modelContext.save()
        } catch {
            print("Error increasing threshold: \(error)")
        }
    }
}
