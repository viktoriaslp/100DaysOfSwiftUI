//
//  Prospect.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import Foundation
import SwiftData

// Model class representing a person in the app (a potential contact)
@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    // Track when the contact was added, for sorting purpose
    var dateAdded = Date.now
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
