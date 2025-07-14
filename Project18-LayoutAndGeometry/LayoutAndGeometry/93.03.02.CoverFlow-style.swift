//
//  Scrolling horizontal efect.swift
//  LayoutAndGeometry
//
//  Created by Victoria Slyunko on 11/7/25.
//

import SwiftUI

struct Scrolling_horizontal_efect: View {
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(1..<20) { num in
                        GeometryReader { proxy in
                            Text("Number \(num)")
                                .font(.largeTitle)
                                .padding()
                                .background(.red)
                                .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                                .frame(width: 200, height: 200)
                        }
                        .frame(width: 200, height: 200)
                    }
                }
            }
        }
}

#Preview {
    Scrolling_horizontal_efect()
}
