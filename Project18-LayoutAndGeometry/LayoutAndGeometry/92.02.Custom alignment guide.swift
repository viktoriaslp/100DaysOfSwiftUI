//
//  92.02.Custom alignment guide.swift
//  LayoutAndGeometry
//
//  Created by Victoria Slyunko on 11/7/25.
//

import SwiftUI

// Custom vertical alignment guide.
extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        // Default position if no alignmentGuide() is used.
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct Custom_alignment_guide: View {
    var body: some View {
        // HStack aligns its children using the custom guide
        HStack(alignment: .midAccountAndName) {
            VStack {
                // Aligns this text using its center
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                // Aligns this text using its center
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
        }
}

#Preview {
    Custom_alignment_guide()
}
