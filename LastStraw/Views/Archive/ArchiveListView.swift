//
//  ArchiveListView.swift
//  LastStraw
//

import SwiftUI
import SwiftData

struct ArchiveListView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Query(
        filter: #Predicate<Person> { $0.isArchived },
        sort: \Person.archivedAt,
        order: .reverse
    ) private var archivedPeople: [Person]
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
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
                            .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
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
