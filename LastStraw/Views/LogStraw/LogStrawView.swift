//
//  LogStrawView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI
import SwiftData

struct LogStrawView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let person: Person
    
    @State private var whatHappened: String = ""
    @State private var howIFelt: String = ""
    @State private var selectedEmotions: Set<EmotionTag> = []
    @State private var showConfirmation = false
    
    private let maxCharacters = 280
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                Form {
                    Section {
                        VStack(alignment: .leading, spacing: 8) {
                            TextEditor(text: $whatHappened)
                                .frame(minHeight: 100)
                                .font(.system(size: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.appTextSecondary.opacity(0.3), lineWidth: 1)
                                )
                            
                            HStack {
                                Spacer()
                                Text("\(whatHappened.count)/\(maxCharacters)")
                                    .font(.system(size: 12))
                                    .foregroundColor(whatHappened.count > maxCharacters ? .red : .appTextSecondary)
                            }
                        }
                    } header: {
                        Text("What happened?")
                            .foregroundColor(.appText)
                    }
                    
                    Section {
                        TextEditor(text: $howIFelt)
                            .frame(minHeight: 80)
                            .font(.system(size: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.appTextSecondary.opacity(0.3), lineWidth: 1)
                            )
                    } header: {
                        Text("How did it make you feel?")
                            .foregroundColor(.appText)
                    } footer: {
                        Text("Optional, but helpful for reflection later.")
                            .font(.system(size: 14))
                            .foregroundColor(.appTextSecondary)
                    }
                    
                    Section {
                        EmotionTagPicker(selectedEmotions: $selectedEmotions)
                    } header: {
                        Text("Emotions")
                            .foregroundColor(.appText)
                    } footer: {
                        Text("Select any that apply.")
                            .font(.system(size: 14))
                            .foregroundColor(.appTextSecondary)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Log a Moment")
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
                        saveStraw()
                    }
                    .foregroundColor(.appPrimary)
                    .fontWeight(.semibold)
                    .disabled(whatHappened.trimmingCharacters(in: .whitespaces).isEmpty || whatHappened.count > maxCharacters)
                }
            }
            .alert("Saved", isPresented: $showConfirmation) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text(AppCopy.afterLoggingStraw)
            }
        }
    }
    
    private func saveStraw() {
        let trimmedWhatHappened = whatHappened.trimmingCharacters(in: .whitespaces)
        guard !trimmedWhatHappened.isEmpty else { return }
        
        let straw = Straw(
            whatHappened: trimmedWhatHappened,
            howIFelt: howIFelt.trimmingCharacters(in: .whitespaces),
            emotionTags: Array(selectedEmotions)
        )
        
        straw.person = person
        person.straws.append(straw)
        
        try? modelContext.save()
        showConfirmation = true
    }
}
