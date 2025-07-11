//
//  86.01.How to use gestures in SwiftUI.swift
//  Flashzilla
//
//  Created by Victoria Slyunko on 7/7/25.
//

import SwiftUI

struct How_to_use_gestures_in_SwiftUI: View {
    
    // For magnifying effect
    @State private var currentAmount = 0.0
    @State private var finalAmoun = 1.0
    
    // For rotation effect
    @State private var currentRotationAmount = Angle.zero
    @State private var finalRotationAmount = Angle.zero
    
    var body: some View {
        
        // Double tap gesture
        Text("Double tap!")
            .padding()
            .onTapGesture(count: 2) {
                print("Double tapped")
            }
        
        // Long press gesture
        Text("Long Tap!")
            .padding()
            .onLongPressGesture(minimumDuration: 2) {
                print("Long Pressed!")
            } onPressingChanged: { inProgress in
                print("isPressed: \(inProgress)")
            }
        
        // Advanced gestures: gesture() + one of those: DragGesture, LongPressGesture, MagnifyGesture, RotateGesture, and TapGesture.
        // Magnification (pinch to zoom) gesture
        Text("Magnifying effect!")
            .padding()
            .scaleEffect(currentAmount + finalAmoun)
            .gesture (
                MagnifyGesture()
                    .onChanged { value in
                        currentAmount = value.magnification - 1
                    }
                    .onEnded { value in
                        finalAmoun += currentAmount
                        currentAmount = 0
                    }
                )
        
        // Rotation gesture
        Text("Rotation effect!")
            .padding()
            .rotationEffect(currentRotationAmount + finalRotationAmount)
            .gesture (
                RotateGesture()
                    .onChanged { value in
                        currentRotationAmount = value.rotation
                    }
                    .onEnded { value in
                        finalRotationAmount += currentRotationAmount
                        currentRotationAmount = .zero
                    }
            )
        
        // Combining gestures: child vs parent tap
        VStack {
            Text("Gestures Clash!")
                .padding()
                .onTapGesture {
                    print("Text tapped")
                }
        }
        // Priority for child (Text) default.
        .onTapGesture {
            print("VStack tapped")
        }
        // To give priority to the parent gesture
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    print("VStack tapped")
                }
        )
        
        // To allow both gestures (child + parent) to trigger:
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    print("VStack tapped")
                }
        )

    }
}

#Preview {
    How_to_use_gestures_in_SwiftUI()
}
