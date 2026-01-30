//
//  PersonDetailView.swift
//  LastStraw
//

import SwiftUI
import SwiftData

struct PersonDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    let person: Person
    @State private var showLogStraw = false
    @State private var showAddBloom = false
    @State private var showArchiveFlow = false
    @State private var showThresholdOptions = false
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header card
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
                                }
                                Spacer()
                            }
                            ProgressIndicatorView(person: person)
                            if person.hasReachedThreshold {
                                ThresholdReachedBanner(
                                    onSitWithIt: { },
                                    onMakeDecision: { showArchiveFlow = true },
                                    onKeepObserving: { showThresholdOptions = true }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    // Timeline
                    if timelineItems.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 40))
                                .foregroundColor(theme.mutedForeground.opacity(0.6))
                            Text("No moments logged yet")
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
                                .padding(.horizontal, 16)
                            ForEach(timelineItems) { item in
                                timelineRow(for: item)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.bottom, 100)
            }
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: { showLogStraw = true }) {
                        Label("Log a straw", systemImage: "plus")
                    }
                    Button(action: { showAddBloom = true }) {
                        Label("Log a bloom", systemImage: "leaf")
                    }
                    if !person.hasReachedThreshold {
                        Button(role: .destructive, action: { showArchiveFlow = true }) {
                            Label("Archive", systemImage: "archivebox")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(accent)
                }
            }
        }
        .sheet(isPresented: $showLogStraw) {
            LogStrawView(person: person)
        }
        .sheet(isPresented: $showAddBloom) {
            AddBloomView(person: person)
        }
        .sheet(isPresented: $showArchiveFlow) {
            ArchiveFlowView(person: person)
        }
        .sheet(isPresented: $showThresholdOptions) {
            IncreaseThresholdView(person: person)
        }
    }
    
    private enum TimelineItem: Identifiable {
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
    
    private var timelineItems: [TimelineItem] {
        let straws: [TimelineItem] = person.straws.map { .straw($0) }
        let blooms: [TimelineItem] = person.blooms.map { .bloom($0) }
        let exts: [TimelineItem] = person.thresholdExtensions.map { .extensionItem($0) }
        return (straws + blooms + exts).sorted { $0.date > $1.date }
    }
    
    @ViewBuilder
    private func timelineRow(for item: TimelineItem) -> some View {
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
