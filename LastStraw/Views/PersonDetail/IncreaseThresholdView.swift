//
//  IncreaseThresholdView.swift
//  LastStraw
//

import SwiftUI
import SwiftData

struct IncreaseThresholdView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    let person: Person
    @State private var newThreshold: Int
    
    init(person: Person) {
        self.person = person
        _newThreshold = State(initialValue: person.threshold)
    }
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                Form {
                    Section {
                        Stepper(value: $newThreshold, in: person.threshold...20) {
                            Text("\(newThreshold) moments")
                                .font(.body)
                        }
                    } header: {
                        Text("New threshold")
                            .foregroundColor(theme.foreground)
                    } footer: {
                        Text("You can always change this later.")
                            .font(.footnote)
                            .foregroundColor(theme.mutedForeground)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Adjust threshold")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(theme.foreground)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveThreshold()
                    }
                    .foregroundColor(accent)
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    private func saveThreshold() {
        let amount = newThreshold - person.threshold
        if amount > 0 {
            let ext = ThresholdExtension(amount: amount, previousThreshold: person.threshold)
            ext.person = person
            person.thresholdExtensions.append(ext)
        }
        person.threshold = newThreshold
        person.thresholdState = .observing
        do {
            try modelContext.save()
            print("✅ Successfully updated threshold")
        } catch {
            print("❌ Failed to update threshold: \(error)")
        }
        dismiss()
    }
}
