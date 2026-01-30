//
//  ThresholdReachedSheet.swift
//  LastStraw
//

import SwiftUI
import SwiftData
import UIKit

struct ThresholdReachedSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    
    let person: Person
    let onArchive: () -> Void
    
    @State private var selectedOption: Option? = nil
    @State private var extensionAmount: Int = 3
    
    enum Option {
        case archive, extend, observe
    }
    
    private let extensionOptions = [1, 2, 3, 5]
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    private var accent: Color { settings.accentColor.color }
    
    var body: some View {
        NavigationStack {
            ZStack {
                theme.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 8) {
                            Text("💭")
                                .font(.system(size: 48))
                            Text("You've reached your threshold")
                                .font(.display(22, weight: .bold))
                                .foregroundColor(theme.foreground)
                            Text("Take a moment. There's no rush.")
                                .font(.body)
                                .foregroundColor(theme.mutedForeground)
                        }
                        .padding(.top, 20)
                        
                        // Options
                        VStack(spacing: 12) {
                            // Archive Option
                            OptionButton(
                                icon: "archivebox.fill",
                                title: "I've seen enough",
                                subtitle: "Archive this relationship. You can revisit anytime.",
                                isSelected: selectedOption == .archive,
                                action: { selectedOption = .archive }
                            )
                            
                            // Extend Option
                            OptionButton(
                                icon: "clock.fill",
                                title: "I'm not ready yet",
                                subtitle: "Give yourself more time. Add more straws to your threshold.",
                                isSelected: selectedOption == .extend,
                                action: { selectedOption = .extend }
                            )
                            
                            // Extension Amount Picker
                            if selectedOption == .extend {
                                HStack(spacing: 8) {
                                    Text("How many more straws?")
                                        .font(.subheadline)
                                        .foregroundColor(theme.mutedForeground)
                                    Spacer()
                                    ForEach(extensionOptions, id: \.self) { amount in
                                        Button(action: { extensionAmount = amount }) {
                                            Text("+\(amount)")
                                                .font(.display(14, weight: .medium))
                                                .frame(width: 44, height: 44)
                                                .background(
                                                    extensionAmount == amount
                                                        ? accent
                                                        : theme.muted
                                                )
                                                .foregroundColor(
                                                    extensionAmount == amount
                                                        ? theme.primaryForeground
                                                        : theme.foreground
                                                )
                                                .clipShape(Circle())
                                        }
                                    }
                                }
                                .padding()
                                .background(theme.secondary.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                            
                            // Observe Option
                            OptionButton(
                                icon: "eye.fill",
                                title: "Keep observing",
                                subtitle: "Stay at threshold, keep logging moments. No pressure, just journaling.",
                                isSelected: selectedOption == .observe,
                                action: { selectedOption = .observe }
                            )
                        }
                        .padding(.horizontal, 20)
                        
                        // Action Button
                        Button(action: handleAction) {
                            Text(actionButtonTitle)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(BubbleButtonStyle())
                        .disabled(selectedOption == nil)
                        .opacity(selectedOption == nil ? 0.5 : 1)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Later") { dismiss() }
                        .foregroundColor(theme.mutedForeground)
                }
            }
            .onAppear {
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
        }
    }
    
    private var actionButtonTitle: String {
        switch selectedOption {
        case .archive: return "Archive this relationship"
        case .extend: return "Add \(extensionAmount) more straws"
        case .observe: return "Enter observing mode"
        case nil: return "Choose an option"
        }
    }
    
    private func handleAction() {
        switch selectedOption {
        case .archive:
            onArchive()
            dismiss()
        case .extend:
            let ext = ThresholdExtension(amount: extensionAmount, previousThreshold: person.threshold)
            ext.person = person
            if person.thresholdExtensions == nil { person.thresholdExtensions = [] }
            person.thresholdExtensions?.append(ext)
            person.threshold += extensionAmount
            do {
                try modelContext.save()
                print("✅ Successfully extended threshold")
            } catch {
                print("❌ Failed to extend threshold: \(error)")
            }
            dismiss()
        case .observe:
            person.thresholdState = .observing
            do {
                try modelContext.save()
                print("✅ Successfully set observing state")
            } catch {
                print("❌ Failed to set observing state: \(error)")
            }
            dismiss()
        case nil:
            break
        }
    }
}

struct OptionButton: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let icon: String
    let title: String
    let subtitle: String
    let isSelected: Bool
    let action: () -> Void
    
    private var theme: ThemeColors { Theme.colors(for: colorScheme) }
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: 12) {
                Circle()
                    .fill(theme.muted)
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(theme.foreground)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.display(16, weight: .semibold))
                        .foregroundColor(theme.foreground)
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundColor(theme.mutedForeground)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
            }
            .padding()
            .background(theme.card)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? theme.primary : theme.border, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}
