//
//  ContentView.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 3/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            // Tab showing all prospects (no filter)
            SortableProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.crop.circle")
                }
            
            // Tab showing only contacted prospects
            SortableProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            // Tab showing only uncontacted prospects
            SortableProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond.fill")
                }
            
            // Tab for the user's own profile/settings
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
