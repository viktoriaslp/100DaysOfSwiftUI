//
//  96. Side by side navigation.swift
//  SnowSeeker
//
//  Created by Victoria Slyunko on 15/7/25.
//

import SwiftUI

struct Side_by_side_navigation: View {
    var body: some View {
        // To prefer the detail view by default: (preferredCompactColumn: .constant(.detail))
        NavigationSplitView(columnVisibility: .constant(.all)) {
            NavigationLink("Primary") {
                Text("New view")
            }
        } detail: {
            Text("Content")
                .navigationTitle("Content view")
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    Side_by_side_navigation()
}
