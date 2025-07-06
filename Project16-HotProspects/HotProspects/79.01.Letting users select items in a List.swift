//
//  Letting users select items in a List.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import SwiftUI

struct Letting_users_select_items_in_a_List: View {
    let users = ["Tomy", "John", "Mary", "Vika"]
    @State private var selected = Set<String>()
    
    var body: some View {
        List(users, id: \.self, selection: $selected) { user in
            Text(user)
        }
        
        if selected.isEmpty == false {
            Text("You selected: \(selected.formatted())")
        }
        
        EditButton()
    }
}

#Preview {
    Letting_users_select_items_in_a_List()
}
