//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Victoria Slyunko on 25.04.2025.
//

import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
