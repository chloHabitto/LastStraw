//
//  AddPersonView.swift
//  LastStraw
//

import SwiftUI
import SwiftData

struct AddPersonView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    @State private var name: String = ""
    @State private var relationshipType: RelationshipType = .friend
    @State private var relationshipCustom: String = ""
    @State private var threshold: Int = 5
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    private var relationshipValue: String {
        relationshipType == .other ? relationshipCustom : relationshipType.rawValue
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                
                Form {
                    Section {
                        TextField("Name", text: $name)
                            .font(.body)
                    } header: {
                        Text("Who is this about?")
                            .foregroundColor(theme.foreground)
                    }
                    
                    Section {
                        Picker("Relationship", selection: $relationshipType) {
                            ForEach(RelationshipType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .font(.body)
                        
                        if relationshipType == .other {
                            TextField("Describe relationship", text: $relationshipCustom)
                                .font(.body)
                        }
                    } header: {
                        Text("Relationship")
                            .foregroundColor(theme.foreground)
                    }
                    
                    Section {
                        Stepper(value: $threshold, in: 3...10) {
                            Text("\(threshold) moments")
                                .font(.body)
                        }
                        Text(AppCopy.thresholdQuestion)
                            .font(.footnote)
                            .foregroundColor(theme.mutedForeground)
                    } header: {
                        Text("Threshold")
                            .foregroundColor(theme.foreground)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Add Person")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { threshold = settings.defaultThreshold }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(theme.foreground)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        savePerson()
                    }
                    .foregroundColor(accent)
                    .fontWeight(.semibold)
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || (relationshipType == .other && relationshipCustom.trimmingCharacters(in: .whitespaces).isEmpty))
                }
            }
        }
    }
    
    private func savePerson() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        let rel = relationshipType == .other ? relationshipCustom.trimmingCharacters(in: .whitespaces) : relationshipType.rawValue
        guard !rel.isEmpty else { return }
        
        let colorIndex = Int.random(in: 0..<Theme.personColors.count)
        let person = Person(name: trimmedName, relationship: rel, threshold: threshold, colorIndex: colorIndex)
        modelContext.insert(person)
        try? modelContext.save()
        dismiss()
    }
}
