//
//  ArchiveFlowView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

struct ArchiveFlowView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let person: Person
    
    @State private var reflection: String = ""
    @State private var decision: String = ""
    @State private var showCompletion = false
    
    private let decisionOptions = [
        "Talked to them",
        "Created distance",
        "Ended it",
        "Letting go",
        "Other"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        AppCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(AppCopy.archivePrompt)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.appText)
                                
                                Text(AppCopy.archiveReflectionPlaceholder)
                                    .font(.system(size: 16))
                                    .foregroundColor(.appTextSecondary)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        
                        Form {
                            Section {
                                TextEditor(text: $reflection)
                                    .frame(minHeight: 120)
                                    .font(.system(size: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.appTextSecondary.opacity(0.3), lineWidth: 1)
                                    )
                            } header: {
                                Text("Reflection")
                            } footer: {
                                Text("What did tracking this teach you about yourself?")
                                    .font(.system(size: 14))
                            }
                            
                            Section {
                                Picker("Decision", selection: $decision) {
                                    Text("Select an option").tag("")
                                    ForEach(decisionOptions, id: \.self) { option in
                                        Text(option).tag(option)
                                    }
                                }
                                .font(.system(size: 16))
                            } header: {
                                Text("What are you choosing to do?")
                            } footer: {
                                Text("Optional, but can be helpful for closure.")
                                    .font(.system(size: 14))
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .frame(height: 300)
                        
                        AppButton(title: "Archive", action: {
                            archivePerson()
                        }, style: .primary)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Archive")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.appText)
                }
            }
            .alert("Archived", isPresented: $showCompletion) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text(AppCopy.archiveComplete)
            }
        }
    }
    
    private func archivePerson() {
        person.isArchived = true
        person.archivedAt = Date()
        person.archiveReflection = reflection.isEmpty ? nil : reflection
        person.archiveDecision = decision.isEmpty ? nil : decision
        
        try? modelContext.save()
        showCompletion = true
    }
}
