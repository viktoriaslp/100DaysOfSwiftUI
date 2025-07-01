//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Victoria Slyunko on 3/6/25.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
