//
//  96. Making a SwiftUI view searchable.swift
//  SnowSeeker
//
//  Created by Victoria Slyunko on 15/7/25.
//

import SwiftUI

struct Making_a_SwiftUI_view_searchable: View {
    // This state property stores the user’s search input
    @State private var searchText = ""
    // All available data to display
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

    // Computed property that filters names based on the search text
    var filteredNames: [String] {
        if searchText.isEmpty {
            allNames // If search text is empty, show all names
        } else {
            allNames.filter {
                // Otherwise, return only matching names (case and diacritic insensitive)
                $0.localizedStandardContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            // Display the filtered list
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            // Add a search bar linked to searchText
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }
}

#Preview {
    Making_a_SwiftUI_view_searchable()
}
