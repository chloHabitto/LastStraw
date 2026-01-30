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
                // Gradient background (background to bubble-glow)
                LinearGradient(
                    colors: [
                        theme.background,
                        theme.bubbleGlow.opacity(0.3)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Custom header (same style as Settings)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Archived")
                                .font(.display(28, weight: .bold))
                                .foregroundColor(theme.foreground)
                            Text(AppCopy.archiveSubtitle)
                                .font(.system(size: 15))
                                .foregroundColor(theme.mutedForeground)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 8)

                        // Content
                        if archivedPeople.isEmpty {
                            EmptyArchiveView()
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(Array(archivedPeople.enumerated()), id: \.element.id) { index, person in
                                    NavigationLink(destination: ArchivedPersonDetailView(person: person)) {
                                        ArchivedPersonRowView(person: person)
                                    }
                                    .buttonStyle(.plain)
                                    .fadeIn(delay: Double(index) * 0.1)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 96)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
