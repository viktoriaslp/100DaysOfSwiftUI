//
//  Creating tabs with TabView and tabItem().swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import SwiftUI

struct Creating_tabs_with_TabView_and_tabItem__: View {
    @State private var selection = "One"
    
    var body: some View {
        // TabView lets users switch between views using a tab bar
        // `selection` tracks the active tab using tags, allowing programmatic tab changes
        TabView(selection: $selection) {
            Button("Show tab 2") {
                selection = "Two"
            }
            .tabItem {
                Label("One", systemImage: "1.square")
                    .tag("One")
            }
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "2.square")
                }
                .tag("Two")
        }
    }
}

#Preview {
    Creating_tabs_with_TabView_and_tabItem__()
}
