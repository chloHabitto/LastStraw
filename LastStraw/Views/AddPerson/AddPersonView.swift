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
    
    /// When non-nil, we're editing this person instead of creating a new one.
    var personToEdit: Person? = nil
    
    @State private var name: String = ""
    @State private var relationshipType: RelationshipType = .friend
    @State private var relationshipCustom: String = ""
    @State private var threshold: Int = 5
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var isEditing: Bool { personToEdit != nil }
    
    private var relationshipValue: String {
        relationshipType == .other ? relationshipCustom : relationshipType.rawValue
    }
    
    private var displayRelationshipText: String {
        relationshipType == .other
            ? (relationshipCustom.isEmpty ? AppCopy.addPersonRelationshipPlaceholder : relationshipCustom)
            : relationshipType.rawValue
    }
    
    private var canSave: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return false }
        if relationshipType == .other {
            return !relationshipCustom.trimmingCharacters(in: .whitespaces).isEmpty
        }
        return true
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        header.fadeIn(delay: 0.1)
                        nameField.fadeIn(delay: 0.15)
                        relationshipField.fadeIn(delay: 0.2)
                        thresholdField.fadeIn(delay: 0.25)
                        actions.fadeIn(delay: 0.3)
                    }
                    .padding(20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let person = personToEdit {
                    name = person.name
                    if let type = RelationshipType(rawValue: person.relationship) {
                        relationshipType = type
                        relationshipCustom = ""
                    } else {
                        relationshipType = .other
                        relationshipCustom = person.relationship
                    }
                    threshold = person.threshold
                } else {
                    threshold = settings.defaultThreshold
                }
            }
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(isEditing ? AppCopy.editPersonTitle : AppCopy.addPersonTitle)
                .font(.display(24, weight: .bold))
                .foregroundColor(theme.foreground)
            Text(isEditing ? AppCopy.editPersonDescription : AppCopy.addPersonDescription)
                .font(.body)
                .foregroundColor(theme.mutedForeground)
        }
    }
    
    private var nameField: some View {
        BubbleTextField(
            label: AppCopy.addPersonNameLabel,
            placeholder: AppCopy.addPersonNamePlaceholder,
            text: $name
        )
    }
    
    private var relationshipField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(AppCopy.addPersonRelationshipLabel)
                .font(.body)
                .foregroundColor(theme.foreground)
            
            Menu {
                ForEach(RelationshipType.allCases, id: \.self) { type in
                    Button(type.rawValue) { relationshipType = type }
                }
            } label: {
                HStack {
                    Text(displayRelationshipText)
                        .font(.body)
                        .foregroundColor(displayRelationshipText == AppCopy.addPersonRelationshipPlaceholder ? theme.mutedForeground : theme.foreground)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.body.weight(.medium))
                        .foregroundColor(theme.mutedForeground)
                }
                .padding(.horizontal, 16)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .background(theme.input)
                .clipShape(RoundedRectangle(cornerRadius: 32))
            }
            
            if relationshipType == .other {
                BubbleTextField(
                    label: "",
                    placeholder: AppCopy.addPersonRelationshipOtherPlaceholder,
                    text: $relationshipCustom
                )
            }
        }
    }
    
    private var thresholdField: some View {
        BubbleSlider(
            label: AppCopy.thresholdLabel,
            helperFormat: AppCopy.thresholdHelper,
            value: $threshold
        )
    }
    
    private var actions: some View {
        VStack(spacing: 12) {
            BubbleButton(title: "Save", action: savePerson, isDisabled: !canSave)
            BubbleButton(title: "Cancel", action: { dismiss() }, style: .secondary)
        }
    }
    
    private func savePerson() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        let rel = relationshipType == .other ? relationshipCustom.trimmingCharacters(in: .whitespaces) : relationshipType.rawValue
        guard !rel.isEmpty else { return }
        
        do {
            if let person = personToEdit {
                person.name = trimmedName
                person.relationship = rel
                person.threshold = threshold
                try modelContext.save()
                print("✅ Successfully updated person: \(trimmedName)")
            } else {
                let colorIndex = Int.random(in: 0..<Theme.personColors.count)
                let person = Person(name: trimmedName, relationship: rel, threshold: threshold, colorIndex: colorIndex)
                modelContext.insert(person)
                try modelContext.save()
                print("✅ Successfully saved person: \(trimmedName)")
            }
        } catch {
            print("❌ Failed to save person: \(error)")
        }
        dismiss()
    }
}
