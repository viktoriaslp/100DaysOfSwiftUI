//
//  93.01.GeometryReader.swift
//  LayoutAndGeometry
//
//  Created by Victoria Slyunko on 11/7/25.
//

import SwiftUI

struct GeometryReaderUse: View {
    var body: some View {
        HStack {
            Text("IMPORTANT")
                .frame(width: 200)
                .background(.blue)

            // GeometryReader provides access to the size of the space given to it by the parent (HStack)
            GeometryReader { proxy in
                Image(.fantasy)
                    .resizable()
                    .scaledToFit()
                    // Set the image width to 80% of the available width from GeometryReader
                    .frame(width: proxy.size.width * 0.8)
                    // Then reapply the full size to center the image within its original space 
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
    }
}

#Preview {
    GeometryReaderUse()
}
