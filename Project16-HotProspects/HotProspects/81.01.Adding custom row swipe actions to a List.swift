//
//  81.01.Adding custom row swipe actions to a List.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import SwiftUI

struct _1_01_Adding_custom_row_swipe_actions_to_a_List: View {
    var body: some View {
        List {
            // Swipe actions on both sides:
            // -> Default (trailing) swipe shows a destructive "Delete" button
            // -> Leading swipe (left to right) shows a "Pin" button with orange tint
            Text("Swioe right")
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Deliting")
                    }
                }
            
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("pining")
                    }
                    .tint(.orange)
                }
        }
    }
}

#Preview {
    _1_01_Adding_custom_row_swipe_actions_to_a_List()
}
