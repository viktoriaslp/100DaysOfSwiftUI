//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Victoria Slyunko on 09.04.2025.
//

import SwiftUI

//TODO: Create a custom ViewModifier
        // large, blue font suitable for prominent titles in a vie
struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

//TODO: Create a View extension
extension View {
    func titleStyle() -> some View {
        modifier(ProminentTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Testing")
            .titleStyle()
    }
}

#Preview {
    ContentView()
}
