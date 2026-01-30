//
//  ArchiveFlowView.swift
//  LastStraw
//

import SwiftUI
import SwiftData

struct ArchiveFlowView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    let person: Person
    @State private var reflection: String = ""
    @State private var showCompletion = false
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 24) {
                        AppCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(AppCopy.archivePrompt)
                                    .font(.display(18, weight: .semibold))
                                    .foregroundColor(theme.foreground)
                                Text(AppCopy.archiveReflectionPlaceholder)
                                    .font(.body)
                                    .foregroundColor(theme.mutedForeground)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        
                        Form {
                            Section {
                                TextField("What did tracking this teach you?", text: $reflection, axis: .vertical)
                                    .lineLimit(4...8)
                                    .font(.body)
                            } header: {
                                Text("Reflection (optional)")
                                    .foregroundColor(theme.foreground)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .frame(height: 140)
                        
                        Button(action: archivePerson) {
                            Text("Archive")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                        }
                        .buttonStyle(BubbleButtonStyle())
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Archive")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(theme.foreground)
                }
            }
            .alert("Archived", isPresented: $showCompletion) {
                Button("OK") { dismiss() }
            } message: {
                Text(AppCopy.archiveComplete)
            }
        }
    }
    
    private func archivePerson() {
        person.isArchived = true
        person.archivedAt = Date()
        try? modelContext.save()
        showCompletion = true
    }
}
