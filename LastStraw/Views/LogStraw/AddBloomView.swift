//
//  AddBloomView.swift
//  LastStraw
//

import SwiftUI
import SwiftData

struct AddBloomView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    let person: Person
    @State private var feeling: BloomFeeling = .grateful
    @State private var note: String = ""
    @State private var showConfirmation = false
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                Form {
                    Section {
                        BloomFeelingPicker(selection: $feeling)
                    } header: {
                        Text("How did you feel?")
                            .foregroundColor(theme.foreground)
                    }
                    Section {
                        TextField("A small moment worth remembering...", text: $note, axis: .vertical)
                            .lineLimit(3...6)
                            .font(.body)
                    } header: {
                        Text("Note")
                            .foregroundColor(theme.foreground)
                    }
                    Section {
                        Button(action: saveBloom) {
                            Text("🌸 Add this bloom")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BubbleButtonStyle())
                        .padding()
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Log a Bloom")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(theme.foreground)
                }
            }
            .alert("Saved", isPresented: $showConfirmation) {
                Button("OK") { dismiss() }
            } message: {
                Text("Your good moment is noted.")
            }
        }
    }
    
    private func saveBloom() {
        let bloom = Bloom(feeling: feeling, note: note.trimmingCharacters(in: .whitespaces))
        bloom.person = person
        person.blooms.append(bloom)
        try? modelContext.save()
        showConfirmation = true
    }
}
