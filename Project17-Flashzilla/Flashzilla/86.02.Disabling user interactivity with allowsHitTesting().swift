//
//  86.02.Disabling user interactivity with allowsHitTesting().swift
//  Flashzilla
//
//  Created by Victoria Slyunko on 7/7/25.
//

import SwiftUI

struct Disabling_user_interactivity_with_allowsHitTesting: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
            // to make circule area to tap a rectangle: .contentShape(.rect)
                .onTapGesture {
                    print("Circle tapped!")
                }
            // to ignore the circle: .allowsHitTesting(false)
        }
        
        // by default SwiftUI won’t trigger actions when a stack spacer is tapped.
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        // This make possible to tap in spacer.
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

#Preview {
    Disabling_user_interactivity_with_allowsHitTesting()
}
