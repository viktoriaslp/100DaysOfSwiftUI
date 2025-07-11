//
//  87.02.How to be notified when your SwiftUI app moves to the background.swift
//  Flashzilla
//
//  Created by Victoria Slyunko on 7/7/25.
//

import SwiftUI

struct How_to_be_notified_when_your_SwiftUI_app_moves_to_the_background: View {
    // Property to observe the current scene phase (app state).
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        //Use .onChange(of:) with two parameters (oldPhase and newPhase) to respond to state changes.
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    print("Avtive")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

#Preview {
    How_to_be_notified_when_your_SwiftUI_app_moves_to_the_background()
}
