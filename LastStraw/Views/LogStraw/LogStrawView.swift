//
//  LogStrawView.swift
//  LastStraw
//

import SwiftUI
import SwiftData
import UIKit

struct LogStrawView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    let person: Person
    @State private var emotion: Emotion?
    @State private var note: String = ""
    @State private var showConfirmation = false
    
    private let maxCharacters = 280
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                Form {
                    Section {
                        EmotionPicker(selection: $emotion)
                    } header: {
                        Text("How did it make you feel?")
                            .foregroundColor(theme.foreground)
                    } footer: {
                        Text("Your feelings are valid. Take a moment to name them.")
                            .font(.footnote)
                            .foregroundColor(theme.mutedForeground)
                    }
                    Section {
                        VStack(alignment: .leading, spacing: 8) {
                            TextField("Just for you — a few words to remember this moment...", text: $note, axis: .vertical)
                                .lineLimit(3...8)
                                .font(.body)
                            HStack {
                                Spacer()
                                Text("\(note.count)/\(maxCharacters)")
                                    .font(.caption)
                                    .foregroundColor(note.count > maxCharacters ? theme.destructive : theme.mutedForeground)
                            }
                        }
                    } header: {
                        Text("Note")
                            .foregroundColor(theme.foreground)
                    } footer: {
                        Text("Optional, but helpful for reflection later.")
                            .font(.footnote)
                            .foregroundColor(theme.mutedForeground)
                    }
                    Section {
                        Button(action: saveStraw) {
                            Text("Log this moment")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BubbleButtonStyle())
                        .disabled(emotion == nil || note.count > maxCharacters)
                        .padding()
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("What happened with \(person.name)?")
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
                Text(AppCopy.afterLoggingStraw)
            }
        }
    }
    
    private func saveStraw() {
        guard let emotion else { return }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        let straw = Straw(emotion: emotion, note: note.trimmingCharacters(in: .whitespaces))
        straw.person = person
        person.straws.append(straw)
        try? modelContext.save()
        showConfirmation = true
    }
}
