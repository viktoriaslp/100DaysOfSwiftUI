//
//  93.02.Frames and Coordinates.swift
//  LayoutAndGeometry
//
//  Created by Victoria Slyunko on 11/7/25.
//

import SwiftUI

// This view contains a vertical stack with three elements: a top label, a nested view (InnerView), and a bottom label.
struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green) // Background to visualize the bounds of InnerView
            Text("Bottom")
        }
    }
}

// This nested view contains a horizontal stack with three elements: left text, a GeometryReader, and right text.
struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { proxy in
                Text("Center")
                    .background(.blue) // Background to visualize the bounds of the Center text
                    .onTapGesture {
                        // Print the center coordinates of the proxy's frame in different coordinate spaces
                        print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
                        print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
                        print("Local center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
                    }
            }
            .background(.orange) // Background to visualize the bounds of the GeometryReader
            Text("Right")
        }
    }
}

// This main view wraps the entire layout and defines a named coordinate space.
struct Frames_and_Coordinates: View {
    var body: some View {
        OuterView()
            .background(.red) // Background to visualize the bounds of OuterView
            .coordinateSpace(name: "Custom") // Adds a named coordinate space that we can reference inside GeometryReader
    }
}

#Preview {
    Frames_and_Coordinates()
}
