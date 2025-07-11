//
//  CardView.swift
//  Flashzilla
//
//  Created by Victoria Slyunko on 7/7/25.
//

import SwiftUI

// Extend Shape to allow conditional fill color based on the swipe direction.
extension Shape {
    func fill(using offset: CGSize) -> some View {
        if offset.width == 0 {
            self.fill(.white)
        } else if offset.width < 0 {
            self.fill(.red)
        } else {
            self.fill(.green)
        }
    }
}

struct CardView: View {
    // Accessibility settings from the environment.
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    // Local state: answer visibility and current drag offset
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    let card: Card
    // Closure that reports swipe direction: true for left (incorrect), false for right (correct)
    var removal: ((Bool) -> Void)? = nil
    
    var body: some View {
            ZStack {
            // Card shape and background color handling based on offset and accessibility
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        accessibilityDifferentiateWithoutColor
                        ? .white // Use plain color if color differentiation is disabled
                        : .white
                            .opacity(1 - Double(abs(offset.width / 50)))
                    )
                    .background(
                        accessibilityDifferentiateWithoutColor
                        ? nil // No colored background if accessibility setting is active
                        : RoundedRectangle(cornerRadius: 25)
                            .fill(using: offset) // Custom fill based on drag direction
                    )
                    .shadow(radius: 10)

                VStack {
                    // If VoiceOver is active, show one text block only.
                    if accessibilityVoiceOverEnabled {
                        Text(isShowingAnswer ? card.answer : card.prompt)
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    } else {
                    // Otherwise show prompt and optionally the answer
                        Text(card.prompt)
                            .font(.largeTitle)
                            .foregroundStyle(.black)

                        if isShowingAnswer {
                            Text(card.answer)
                                .font(.title)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .frame(width: 450, height: 250)
            // Apply rotation and offset based on drag amount
            .rotationEffect(.degrees(offset.width / 5.0))
            .offset(x: offset.width * 5)
            .opacity(2 - Double(abs(offset.width / 50)))
            .accessibilityAddTraits(.isButton)
            
            // Add drag gesture to update offset and trigger removal when dragged far enough
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            if offset.width > 0 {
                                removal?(false)
                            } else {
                                removal?(true)
                            }
                        } else {
                            offset = .zero
                        }
                    }
            )
            // Tap to toggle answer visibility
            .onTapGesture {
                isShowingAnswer.toggle()
            }
            // Animate changes to the offset
            .animation(.bouncy, value: offset)
        }
}

#Preview {
    CardView(card: .example)
}
