//
//  EditingView.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 6/7/25.
//

import SwiftData
import SwiftUI

struct EditingView: View {
    // This allows live two-way updates
    @Bindable var prospect: Prospect
    
    var body: some View {
        // Basic form to edit the name, email, and contact status of a prospect.
        Form {
            TextField("Name", text: $prospect.name)
            TextField("Email", text: $prospect.emailAddress)
            Toggle("Contacted", isOn: $prospect.isContacted)
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        // Set up an in-memory model container for previewing
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let example = Prospect(name: "Example User", emailAddress: "example@example.com", isContacted: false)
        return EditingView(prospect: example)
            .modelContainer(container)
    } catch {
        return Text("Error loading preview data: \(error.localizedDescription)")
    }
}
