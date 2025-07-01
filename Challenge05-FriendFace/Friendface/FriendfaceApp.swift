//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Victoria Slyunko on 16/6/25.
//

import SwiftData
import SwiftUI

@main
struct FriendfaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
