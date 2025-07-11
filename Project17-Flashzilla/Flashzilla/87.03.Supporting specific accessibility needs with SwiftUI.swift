//
//  87.03.Supporting specific accessibility needs with SwiftUI.swift
//  Flashzilla
//
//  Created by Victoria Slyunko on 7/7/25.
//

import SwiftUI

struct Supporting_specific_accessibility_needs_with_SwiftUI: View {
    // Accessibility colour
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    //Solid black background when Reduce Transparency is enabled
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    // Accessibility motion control
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
    @State private var scale = 1.0
    
    
    var body: some View {
        // Show a different collor deppending on the accessibility settings.
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(.capsule)
        
        // Motion control throu a function
        Button("Hello, World!") {
            withOptionalAnimation {
                scale *= 1.5
            }

        }
        .scaleEffect(scale)
        
        // Transparency control example
        Text("Hello, World!")
                    .padding()
                    .background(reduceTransparency ? .black : .black.opacity(0.5))
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
    }
}

#Preview {
    Supporting_specific_accessibility_needs_with_SwiftUI()
}
