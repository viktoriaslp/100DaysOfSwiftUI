//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 3/7/25.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
