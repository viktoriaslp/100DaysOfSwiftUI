//
//  92.03.Absolute positioning.swift
//  LayoutAndGeometry
//
//  Created by Victoria Slyunko on 11/7/25.
//

import SwiftUI

struct Absolute_positioning: View {
    var body: some View {
        List {
            // position() -> places a view at exact coordinates, centered on the given point, using the parent’s top-left corner (0,0) as reference.
            Text("Hello, world!")
                .position(x: 100, y: 100)
                .background(.red)
            
            Text("Hello, world!")
                .background(.red)
                .position(x: 100, y: 100)
            
            // offset() -> moves a view visually without changing its layout position — the offset is relative to the view’s original location.
            Text("Hello, world!")
                .offset(x: 20, y: 10)
                .background(.red)
            
            Text("Hello, world!")
                .background(.red)
                .offset(x: 20, y: 10)
            
        }
    }
}

#Preview {
    Absolute_positioning()
}
