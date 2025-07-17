//
//  96. Alert and sheet with optional.swift
//  SnowSeeker
//
//  Created by Victoria Slyunko on 15/7/25.
//

import SwiftUI

// Conforming to Identifiable so it can be used with .sheet(item:)
struct User: Identifiable {
    var id = "Taylor Swift"
}

struct Alert_and_sheet_with_optional: View {
    // This optional will be set when we want to show the sheet
    @State private var selectedUser: User? = nil

    // Used for the alert (currently commented out)
    @State private var isShowingUser = false
    
    var body: some View {
        Button("Tap me") {
            selectedUser = User()
            // When tapped, assigns a User to trigger the sheet
        }
        .sheet(item: $selectedUser) { user in
            // This version of .sheet only shows when selectedUser is not nil
            Text(user.id)
                // Allows user to drag the sheet between two sizes
                .presentationDetents([.medium, .large])
        }
//        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//            Button(user.id) { }
//        }
    }
}

#Preview {
    Alert_and_sheet_with_optional()
}
