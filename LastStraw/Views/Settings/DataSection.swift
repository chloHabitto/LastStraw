//
//  DataSection.swift
//  LastStraw
//

import SwiftUI
import SwiftData

struct DataSection: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var modelContext
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        Section {
            NavigationLink {
                ExportDataView()
            } label: {
                Text("Export my data")
                    .foregroundColor(theme.foreground)
            }
            HStack {
                Text("iCloud Sync")
                    .foregroundColor(theme.foreground)
                Spacer()
                Text("Coming soon")
                    .font(.caption)
                    .foregroundColor(theme.mutedForeground)
            }
            .disabled(true)
            Button(role: .destructive) {
                // Delete all data – typically show confirmation
            } label: {
                Text("Delete all data")
            }
        } header: {
            Text("Your data")
                .foregroundColor(theme.mutedForeground)
        }
    }
}

struct ExportDataView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        List {
            Section {
                Text("Export all people, straws, and blooms as JSON. Use Share or Files to save.")
                    .font(.footnote)
                    .foregroundColor(theme.mutedForeground)
                Button("Export JSON") {
                    exportJSON()
                }
                .foregroundColor(theme.primary)
            }
        }
        .navigationTitle("Export data")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func exportJSON() {
        let descriptor = FetchDescriptor<Person>()
        guard let people = try? modelContext.fetch(descriptor) else { return }
        let payload = people.map { person in
            [
                "id": person.id.uuidString,
                "name": person.name,
                "relationship": person.relationship,
                "threshold": person.threshold,
                "isArchived": person.isArchived,
                "createdAt": ISO8601DateFormatter().string(from: person.createdAt),
                "straws": person.straws.map { s in
                    [
                        "id": s.id.uuidString,
                        "emotion": s.emotion.rawValue,
                        "note": s.note,
                        "date": ISO8601DateFormatter().string(from: s.date)
                    ] as [String: Any]
                },
                "blooms": person.blooms.map { b in
                    [
                        "id": b.id.uuidString,
                        "feeling": b.feeling.rawValue,
                        "note": b.note,
                        "date": ISO8601DateFormatter().string(from: b.date)
                    ] as [String: Any]
                }
            ] as [String: Any]
        }
        // In a real app you'd use JSONSerialization and share the file
        print("Export payload (use JSONSerialization in production): \(payload)")
    }
}
