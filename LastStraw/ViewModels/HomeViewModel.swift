//
//  HomeViewModel.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import Foundation
import SwiftData

@Observable
class HomeViewModel {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchActivePeople() -> [Person] {
        let descriptor = FetchDescriptor<Person>(
            predicate: #Predicate { !$0.isArchived },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching active people: \(error)")
            return []
        }
    }
    
    func deletePerson(_ person: Person) {
        modelContext.delete(person)
        do {
            try modelContext.save()
        } catch {
            print("Error deleting person: \(error)")
        }
    }
}
