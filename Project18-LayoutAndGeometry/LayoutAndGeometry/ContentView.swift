//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Victoria Slyunko on 11/7/25.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            // Challenge 3: Cycle background color based on vertical position; min() caps hue value at 1 to avoid color jump issues
                            .background(Color(hue: min(1, proxy.frame(in: .global).minY / fullView.size.height), saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            // Challenge 1: Fade out rows as they approach the top of the scroll view
                            .opacity(proxy.frame(in: .global).minY / 200)
                            // Challenge 2: Scale down rows based on their vertical position. Prevents shrinking below 50% of the original size
                            .scaleEffect(max(0.5, proxy.frame(in: .global).minY / 400))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
