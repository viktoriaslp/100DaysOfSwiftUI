//
//  92.01. Alignment.swift
//  LayoutAndGeometry
//
//  Created by Victoria Slyunko on 11/7/25.
//

import SwiftUI

struct Alignment: View {
    var body: some View {
        List {
            // Example 1: How alignment inside a frame works
            // The text is positioned at the top leading corner of its frame
            Text("Aligning text inside a frame")
                .frame(width: 300, height: 300, alignment: .topLeading)
            
            // Example 2: Using .lastTextBaseline alignment in HStack
            // All texts align by their last baseline, despite different font sizes.
            HStack(alignment: .lastTextBaseline) {
                Text("Live")
                    .font(.caption)
                Text("long")
                Text("and")
                    .font(.title)
                Text("prosper")
                    .font(.largeTitle)
            }
            
            // Example 3: Custom alignment guide
            // The first text aligns its trailing edge with the leading alignment, pushing it to the opposite side
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Hello, world!")
                        .alignmentGuide(.leading) { d in d[.trailing] }
                    Text("This is a longer line of text")
                }
            }
            .background(.red)
            .frame(width: 400, height: 400)
            .background(.blue)
            
            // Example 4: Dynamic alignment based on index
            // Each line is shifted to the left based on its position. 
            VStack(alignment: .leading) {
                ForEach(0..<10) { position in
                    Text("Number \(position)")
                        .alignmentGuide(.leading) { _ in Double(position) * -10 }
                }
            }
            .background(.red)
            .frame(width: 400, height: 400)
            .background(.blue)
        }
    }
}

#Preview {
    Alignment()
}
