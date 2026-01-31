//
//  DataSection.swift
//  LastStraw
//

import SwiftUI
import SwiftData
import UIKit

/// Detail page for data: export, iCloud (disabled), delete all with confirmation.
struct DataDetailView: View {
    @EnvironmentObject private var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var modelContext
    @State private var showDeleteConfirmation = false
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SettingsSection(title: "Your data") {
                        VStack(spacing: 0) {
                            NavigationLink {
                                ExportDataView()
                            } label: {
                                SettingsRow(icon: "square.and.arrow.up", label: "Export my data", description: "Share or save as JSON", showChevron: true, trailing: { EmptyView() })
                            }
                            .buttonStyle(.plain)
                            rowDivider
                            SettingsRow(icon: "icloud.fill", label: "iCloud Sync", description: "Enabled", trailing: { EmptyView() })
                            rowDivider
                            Button {
                                showDeleteConfirmation = true
                            } label: {
                                SettingsRow(icon: "trash.fill", label: "Delete all data", description: "Permanent and irreversible", isDestructive: true, trailing: { EmptyView() })
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Your data")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .alert("Delete all data?", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) { deleteAllData() }
        } message: {
            Text("This will permanently delete all people, straws, and blooms. This cannot be undone.")
        }
    }
    
    private var rowDivider: some View {
        Rectangle()
            .fill(theme.border.opacity(0.3))
            .frame(height: 1)
            .padding(.leading, 16 + 36 + 12)
    }
    
    private func deleteAllData() {
        let descriptor = FetchDescriptor<Person>()
        guard let people = try? modelContext.fetch(descriptor) else { return }
        for person in people {
            modelContext.delete(person)
        }
        do {
            try modelContext.save()
            print("✅ Successfully deleted all data")
        } catch {
            print("❌ Failed to delete all data: \(error)")
        }
    }
}

struct ExportDataView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SettingsSection(title: "Export") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Export all people, straws, and blooms as JSON. Use Share or Files to save.")
                                .font(.system(size: 13))
                                .foregroundColor(theme.mutedForeground)
                            Button {
                                exportJSON()
                            } label: {
                                Text("Export JSON")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(theme.primaryForeground)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(theme.primary)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle("Export data")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func exportJSON() {
        let descriptor = FetchDescriptor<Person>()
        guard let people = try? modelContext.fetch(descriptor) else { return }
        
        let formatter = ISO8601DateFormatter()
        let exportData: [String: Any] = [
            "exportedAt": formatter.string(from: Date()),
            "version": "1.0",
            "data": people.map { person in
                [
                    "id": person.id.uuidString,
                    "name": person.name,
                    "relationship": person.relationship,
                    "threshold": person.threshold,
                    "isArchived": person.isArchived,
                    "createdAt": formatter.string(from: person.createdAt),
                    "archivedAt": person.archivedAt.map { formatter.string(from: $0) } as Any,
                    "colorIndex": person.safeColorIndex,
                    "thresholdState": person.thresholdState.rawValue,
                    "straws": (person.straws ?? []).map { straw in
                        [
                            "id": straw.id.uuidString,
                            "emotion": straw.emotion.rawValue,
                            "note": straw.note,
                            "date": formatter.string(from: straw.date)
                        ] as [String: Any]
                    },
                    "blooms": (person.blooms ?? []).map { bloom in
                        [
                            "id": bloom.id.uuidString,
                            "feeling": bloom.feeling.rawValue,
                            "note": bloom.note,
                            "date": formatter.string(from: bloom.date)
                        ] as [String: Any]
                    },
                    "thresholdExtensions": (person.thresholdExtensions ?? []).map { ext in
                        [
                            "id": ext.id.uuidString,
                            "amount": ext.amount,
                            "previousThreshold": ext.previousThreshold,
                            "date": formatter.string(from: ext.date)
                        ] as [String: Any]
                    }
                ] as [String: Any]
            }
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: exportData, options: .prettyPrinted),
              let jsonString = String(data: jsonData, encoding: .utf8) else { return }
        
        let fileName = "last-straw-export-\(formatter.string(from: Date()).replacingOccurrences(of: ":", with: "-")).json"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        try? jsonString.write(to: tempURL, atomically: true, encoding: .utf8)
        
        let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}

#Preview {
    NavigationStack {
        DataDetailView()
            .environmentObject(AppSettings())
    }
}
