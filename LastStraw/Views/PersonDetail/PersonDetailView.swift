//
//  PersonDetailView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

struct PersonDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let person: Person
    @State private var showLogStraw = false
    @State private var showArchiveFlow = false
    @State private var showThresholdOptions = false
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header Card
                    AppCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(person.name)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.appText)
                            
                            Text(person.relationshipType.rawValue)
                                .font(.system(size: 16))
                                .foregroundColor(.appTextSecondary)
                            
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
                    
                    // Straws List
                    if person.straws.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.appTextSecondary.opacity(0.5))
                            
                            Text("No moments logged yet")
                                .font(.system(size: 16))
                                .foregroundColor(.appTextSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(sortedStraws) { straw in
                                StrawRowView(straw: straw)
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
                        Label("Add Straw", systemImage: "plus")
                    }
                    
                    if !person.hasReachedThreshold {
                        Button(role: .destructive, action: { showArchiveFlow = true }) {
                            Label("Archive", systemImage: "archivebox")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.appPrimary)
                }
            }
        }
        .sheet(isPresented: $showLogStraw) {
            LogStrawView(person: person)
        }
        .sheet(isPresented: $showArchiveFlow) {
            ArchiveFlowView(person: person)
        }
        .sheet(isPresented: $showThresholdOptions) {
            IncreaseThresholdView(person: person)
        }
    }
    
    private var sortedStraws: [Straw] {
        person.straws.sorted { $0.createdAt > $1.createdAt }
    }
}
