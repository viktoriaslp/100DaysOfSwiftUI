//
//  ContentView.swift
//  Animations
//
//  Created by Victoria Slyunko on 20.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation {
                animationAmount += 45
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 1, y: 0, z: 0)
        )
    }
}

#Preview {
    ContentView()
}
