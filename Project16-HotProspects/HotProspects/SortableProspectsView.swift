//
//  SortableProspectsView.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 6/7/25.
//

import SwiftUI

struct SortableProspectsView: View {
    // Store the current filter and the selected sort order (name or date).
    let filter: ProspectsView.FilterType
    @State private var sortOrder = SortDescriptor(\Prospect.name)
    
    var body: some View {
        // Wrap ProspectsView in a NavigationStack and add a sorting menu in the toolbar (it will merge with the existing toolbar inside ProspectsView).
        NavigationStack {
            ProspectsView(filter: filter, sort: sortOrder)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort") {
                            Picker("Sort Order", selection: $sortOrder) {
                                Text("Name")
                                    .tag(SortDescriptor(\Prospect.name))
                                Text("Date added")
                                    .tag(SortDescriptor(\Prospect.dateAdded))
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    SortableProspectsView(filter: .none)
}
