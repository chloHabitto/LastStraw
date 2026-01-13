//
//  AddPersonView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

struct AddPersonView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var relationshipType: RelationshipType = .friend
    @State private var threshold: Int = 5
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                Form {
                    Section {
                        TextField("Name", text: $name)
                            .font(.system(size: 16))
                    } header: {
                        Text("Who is this about?")
                    }
                    
                    Section {
                        Picker("Relationship", selection: $relationshipType) {
                            ForEach(RelationshipType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .font(.system(size: 16))
                    } header: {
                        Text("Relationship Type")
                    }
                    
                    Section {
                        VStack(alignment: .leading, spacing: 12) {
                            Stepper(value: $threshold, in: 3...10) {
                                Text("\(threshold) moments")
                                    .font(.system(size: 16))
                            }
                            
                            Text(AppCopy.thresholdQuestion)
                                .font(.system(size: 14))
                                .foregroundColor(.appTextSecondary)
                        }
                    } header: {
                        Text("Threshold")
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Add Person")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.appText)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        savePerson()
                    }
                    .foregroundColor(.appPrimary)
                    .fontWeight(.semibold)
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
    
    private func savePerson() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        
        let person = Person(
            name: trimmedName,
            relationshipType: relationshipType,
            threshold: threshold
        )
        
        modelContext.insert(person)
        try? modelContext.save()
        dismiss()
    }
}
