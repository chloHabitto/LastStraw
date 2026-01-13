//
//  HomeView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(
        filter: #Predicate<Person> { !$0.isArchived },
        sort: \Person.createdAt,
        order: .reverse
    ) private var activePeople: [Person]
    
    @State private var showAddPerson = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                if activePeople.isEmpty {
                    EmptyHomeView()
                } else {
                    List {
                        ForEach(activePeople) { person in
                            NavigationLink(destination: PersonDetailView(person: person)) {
                                PersonRowView(person: person)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        }
                        .onDelete(perform: deletePeople)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Last Straw")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddPerson = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(.appPrimary)
                    }
                }
            }
            .sheet(isPresented: $showAddPerson) {
                AddPersonView()
            }
        }
    }
    
    private func deletePeople(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(activePeople[index])
        }
        try? modelContext.save()
    }
}
