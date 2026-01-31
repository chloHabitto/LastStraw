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
    @State private var showThresholdReachedSheet = false
    @State private var showEditPerson = false
    
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
                                Button(action: { showThresholdReachedSheet = true }) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("You've reached your threshold")
                                            .font(.display(18, weight: .semibold))
                                            .foregroundColor(theme.foreground)
                                        Text("Take a moment. Tap to choose what to do next.")
                                            .font(.subheadline)
                                            .foregroundColor(theme.mutedForeground)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(theme.secondary.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                                .buttonStyle(.plain)
                                .padding(.top, 8)
                            }
                        }
                    }
                    .scaleIn(delay: 0)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    
                    // Timeline
                    if timelineItems.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 40))
                                .foregroundColor(theme.mutedForeground.opacity(0.6))
                            Text("No moments logged yet")
                                .font(.body)
                                .foregroundColor(theme.mutedForeground)
                            Text("When something happens, you can record it here.")
                                .font(.footnote)
                                .foregroundColor(theme.mutedForeground.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            Text("Your moments")
                                .font(.display(18, weight: .semibold))
                                .foregroundColor(theme.foreground)
                                .padding(.horizontal, 20)
                            ForEach(Array(timelineItems.enumerated()), id: \.element.id) { index, item in
                                timelineRow(for: item)
                                    .fadeIn(delay: Double(index) * 0.05)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                }
                .padding(.bottom, 120)
            }
        }
        .overlay(alignment: .bottom) {
            if !person.isArchived {
                HStack(spacing: 8) {
                    Button(action: { showAddBloom = true }) {
                        HStack(spacing: 8) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 16))
                                .foregroundColor(accent)
                            Text("Add a bloom")
                                .font(.display(14, weight: .medium))
                                .foregroundColor(theme.foreground)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 28)
                            .fill(theme.card.opacity(0.9))
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 28))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(accent.opacity(0.3), lineWidth: 2)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 28))

                    Button(action: { showLogStraw = true }) {
                        HStack(spacing: 8) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Log a straw")
                                .font(.display(14, weight: .medium))
                        }
                        .foregroundColor(theme.foreground)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                    }
                    .background(Theme.gradientY2K)
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                    .shadow(color: theme.primary.opacity(0.25), radius: 12, x: 0, y: 4)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
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
                Menu {
                    if !person.isArchived {
                        Button(action: { showLogStraw = true }) {
                            Label("Log a straw", systemImage: "plus")
                        }
                        Button(action: { showAddBloom = true }) {
                            Label("Log a bloom", systemImage: "leaf")
                        }
                        Button(action: { showArchiveFlow = true }) {
                            Label("Archive", systemImage: "archivebox")
                        }
                    }
                    Button(action: { showEditPerson = true }) {
                        Label("Edit", systemImage: "pencil")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(accent)
                }
            }
        }
        .sheet(isPresented: $showLogStraw) {
            LogStrawView(person: person)
                .environmentObject(settings)
        }
        .sheet(isPresented: $showAddBloom) {
            AddBloomView(person: person)
                .environmentObject(settings)
        }
        .sheet(isPresented: $showArchiveFlow) {
            ArchiveFlowView(person: person)
                .environmentObject(settings)
        }
        .sheet(isPresented: $showThresholdReachedSheet) {
            ThresholdReachedSheet(person: person, onArchive: { showArchiveFlow = true })
                .environmentObject(settings)
        }
        .sheet(isPresented: $showEditPerson) {
            AddPersonView(personToEdit: person)
                .environmentObject(settings)
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
        let straws: [TimelineItem] = (person.straws ?? []).map { .straw($0) }
        let blooms: [TimelineItem] = (person.blooms ?? []).map { .bloom($0) }
        let exts: [TimelineItem] = (person.thresholdExtensions ?? []).map { .extensionItem($0) }
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
