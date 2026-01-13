//
//  ArchivedPersonDetailView.swift
//  LastStraw
//
//  Created by Chloe Lee on 2026-01-13.
//

import SwiftUI

struct ArchivedPersonDetailView: View {
    let person: Person
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header Card
                    AppCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(person.name)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.appText)
                            
                            Text(person.relationshipType.rawValue)
                                .font(.system(size: 16))
                                .foregroundColor(.appTextSecondary)
                            
                            if let archivedAt = person.archivedAt {
                                Text("Archived on \(archivedAt.formatted(style: .long))")
                                    .font(.system(size: 14))
                                    .foregroundColor(.appTextSecondary)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    // Reflection
                    if let reflection = person.archiveReflection, !reflection.isEmpty {
                        AppCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Reflection")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.appText)
                                
                                Text(reflection)
                                    .font(.system(size: 16))
                                    .foregroundColor(.appText)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    // Decision
                    if let decision = person.archiveDecision, !decision.isEmpty {
                        AppCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Decision")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.appText)
                                
                                Text(decision)
                                    .font(.system(size: 16))
                                    .foregroundColor(.appText)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    // All Straws
                    if person.straws.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.appTextSecondary.opacity(0.5))
                            
                            Text("No moments logged")
                                .font(.system(size: 16))
                                .foregroundColor(.appTextSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("All Moments")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.appText)
                                .padding(.horizontal, 16)
                            
                            LazyVStack(spacing: 12) {
                                ForEach(sortedStraws) { straw in
                                    StrawRowView(straw: straw)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var sortedStraws: [Straw] {
        person.straws.sorted { $0.createdAt > $1.createdAt }
    }
}
