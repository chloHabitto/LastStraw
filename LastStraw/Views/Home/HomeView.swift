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
    @State private var selectedPerson: Person?
    
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
                    ScrollView {
                        VStack(spacing: 16) {
                            // Custom hero header (matching React's header)
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Last Straw")
                                    .font(.display(28, weight: .bold))
                                    .foregroundColor(theme.foreground)
                                Text(AppCopy.emptyHomeTagline)
                                    .font(.system(size: 17))
                                    .italic()
                                    .foregroundColor(theme.mutedForeground)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)
                            .padding(.bottom, 6)

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
                            .fadeIn(delay: 0)
                            .padding(.bottom, 8)

                            LazyVStack(spacing: 16) {
                                ForEach(Array(activePeople.enumerated()), id: \.element.id) { index, person in
                                    Button {
                                        selectedPerson = person
                                    } label: {
                                        PersonRowView(person: person)
                                    }
                                    .buttonStyle(.plain)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            deletePerson(person)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                    .scaleIn(delay: Double(index) * 0.08)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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
            .fullScreenCover(item: $selectedPerson) { person in
                NavigationStack {
                    PersonDetailView(person: person)
                        .screenAppear()
                        .environmentObject(settings)
                }
            }
        }
    }
    
    private func deletePerson(_ person: Person) {
        modelContext.delete(person)
        do {
            try modelContext.save()
            print("✅ Successfully deleted person")
        } catch {
            print("❌ Failed to delete person: \(error)")
        }
    }
}
