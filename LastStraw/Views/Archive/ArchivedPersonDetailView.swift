//
//  ArchivedPersonDetailView.swift
//  LastStraw
//

import SwiftUI
import SwiftData

struct ArchivedPersonDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let person: Person
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    private var timelineItems: [ArchivedTimelineItem] {
        let straws = (person.straws ?? []).map { ArchivedTimelineItem.straw($0) }
        let blooms = (person.blooms ?? []).map { ArchivedTimelineItem.bloom($0) }
        let exts = (person.thresholdExtensions ?? []).map { ArchivedTimelineItem.extensionItem($0) }
        return (straws + blooms + exts).sorted { $0.date > $1.date }
    }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    AppCard {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 14) {
                                Circle()
                                    .fill(person.color)
                                    .frame(width: 52, height: 52)
                                    .overlay(
                                        Text(person.initial)
                                            .font(.display(24, weight: .bold))
                                            .foregroundColor(.white)
                                    )
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(person.name)
                                        .font(.display(24, weight: .bold))
                                        .foregroundColor(theme.foreground)
                                    Text(person.relationship)
                                        .font(.subheadline)
                                        .foregroundColor(theme.mutedForeground)
                                    if let archivedAt = person.archivedAt {
                                        Text("Archived \(archivedAt.relativeString())")
                                            .font(.caption)
                                            .foregroundColor(theme.mutedForeground)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    
                    if timelineItems.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 40))
                                .foregroundColor(theme.mutedForeground.opacity(0.6))
                            Text("No moments logged")
                                .font(.body)
                                .foregroundColor(theme.mutedForeground)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            Text("Timeline")
                                .font(.display(18, weight: .semibold))
                                .foregroundColor(theme.foreground)
                                .padding(.horizontal, 20)
                            ForEach(timelineItems) { item in
                                archivedTimelineRow(for: item)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(accent)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: unarchivePerson) {
                    Label("Restore", systemImage: "arrow.uturn.backward")
                }
                .foregroundColor(accent)
            }
        }
    }
    
    private func unarchivePerson() {
        person.isArchived = false
        person.archivedAt = nil
        do {
            try modelContext.save()
            print("✅ Successfully unarchived person")
        } catch {
            print("❌ Failed to unarchive person: \(error)")
        }
        dismiss()
    }
    
    private enum ArchivedTimelineItem: Identifiable {
        case straw(Straw)
        case bloom(Bloom)
        case extensionItem(ThresholdExtension)
        var id: String {
            switch self {
            case .straw(let s): return "s-\(s.id.uuidString)"
            case .bloom(let b): return "b-\(b.id.uuidString)"
            case .extensionItem(let e): return "e-\(e.id.uuidString)"
            }
        }
        var date: Date {
            switch self {
            case .straw(let s): return s.date
            case .bloom(let b): return b.date
            case .extensionItem(let e): return e.date
            }
        }
    }
    
    @ViewBuilder
    private func archivedTimelineRow(for item: ArchivedTimelineItem) -> some View {
        switch item {
        case .straw(let straw):
            StrawRowView(straw: straw)
        case .bloom(let bloom):
            BloomRowView(bloom: bloom)
        case .extensionItem(let ext):
            ThresholdExtensionRowView(extensionItem: ext)
        }
    }
}
