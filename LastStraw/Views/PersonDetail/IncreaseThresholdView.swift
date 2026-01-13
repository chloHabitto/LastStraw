//
//  IncreaseThresholdView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

struct IncreaseThresholdView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let person: Person
    @State private var newThreshold: Int
    
    init(person: Person) {
        self.person = person
        _newThreshold = State(initialValue: person.threshold)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                Form {
                    Section {
                        Stepper(value: $newThreshold, in: person.threshold...20) {
                            Text("\(newThreshold) moments")
                                .font(.system(size: 16))
                        }
                    } header: {
                        Text("New Threshold")
                            .foregroundColor(.appText)
                    } footer: {
                        Text("You can always change this later.")
                            .font(.system(size: 14))
                            .foregroundColor(.appTextSecondary)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Adjust Threshold")
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
                        person.threshold = newThreshold
                        try? modelContext.save()
                        dismiss()
                    }
                    .foregroundColor(.appPrimary)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}
