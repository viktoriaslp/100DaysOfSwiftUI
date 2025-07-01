//
//  RectangleDividers.swift
//  MoonShot
//
//  Created by Victoria Slyunko on 19/5/25.
//

import SwiftUI

struct RectangleDividers: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    RectangleDividers()
}
