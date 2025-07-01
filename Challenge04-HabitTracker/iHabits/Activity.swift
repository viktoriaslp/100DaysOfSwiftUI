//
//  Activity.swift
//  iHabits
//
//  Created by Victoria Slyunko on 22/5/25.
//

import Foundation

struct Activity: Codable, Equatable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount = 0
    
    static let example = Activity(title: "Example", description: "This is an example activity.")
        
}
