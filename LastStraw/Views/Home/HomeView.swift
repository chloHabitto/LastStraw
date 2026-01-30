//
//  HomeView.swift
//  LastStraw
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    @Query(
        filter: #Predicate<Person> { !$0.isArchived },
        sort: \Person.createdAt,
        order: .reverse
    ) private var activePeople: [Person]
    
    @State private var showAddPerson = false
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    private var totalStraws: Int {
        activePeople.reduce(0) { $0 + $1.strawCount }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                
                if activePeople.isEmpty {
                    EmptyHomeView(onAddPerson: { showAddPerson = true })
                } else {
                    VStack(spacing: 0) {
                        if !activePeople.isEmpty {
                            AppCard {
                                HStack(spacing: 0) {
                                    VStack {
                                        Text("\(activePeople.count)")
                                            .font(.display(24, weight: .bold))
                                            .foregroundColor(accent)
                                        Text("People")
                                            .font(.caption)
                                            .foregroundColor(theme.mutedForeground)
                                    }
                                    .frame(maxWidth: .infinity)
                                    Divider()
                                        .frame(height: 40)
                                    VStack {
                                        Text("\(totalStraws)")
                                            .font(.display(24, weight: .bold))
                                            .foregroundColor(accent)
                                        Text("Moments logged")
                                            .font(.caption)
                                            .foregroundColor(theme.mutedForeground)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 8)
                        }
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
            }
            .navigationTitle("Last Straw")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddPerson = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(accent)
                    }
                }
            }
            .sheet(isPresented: $showAddPerson) {
                AddPersonView()
                    .environmentObject(settings)
                    .presentationCornerRadius(32)
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
