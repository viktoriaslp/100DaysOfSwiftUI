//
//  80.03.Creating context menus.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import SwiftUI

struct _0_03_Creating_context_menus: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Colour")
                .padding()
                .background(backgroundColor)
            
            Text("Change colour")
                .padding()
                .contextMenu {
                    Button("Red", systemImage: "checkmark", role: .destructive) {
                        backgroundColor = .red
                    }
                    Button("Green") {
                        backgroundColor = .green
                    }
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

#Preview {
    _0_03_Creating_context_menus()
}
