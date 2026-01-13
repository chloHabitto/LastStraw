//
//  ArchiveListView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

struct ArchiveListView: View {
    @Query(
        filter: #Predicate<Person> { $0.isArchived },
        sort: \Person.archivedAt,
        order: .reverse
    ) private var archivedPeople: [Person]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                if archivedPeople.isEmpty {
                    EmptyArchiveView()
                } else {
                    List {
                        ForEach(archivedPeople) { person in
                            NavigationLink(destination: ArchivedPersonDetailView(person: person)) {
                                ArchivedPersonRowView(person: person)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Archive")
        }
    }
}
