//
//  87.01.Triggering events repeatedly using a timer.swift
//  Flashzilla
//
//  Created by Victoria Slyunko on 7/7/25.
//

import SwiftUI

struct Triggering_events_repeatedly_using_a_timer: View {
    
    // tolerance: 0.5, push back timer - save batery. Less acurate.
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                counter += 1
            }
    }
}

#Preview {
    Triggering_events_repeatedly_using_a_timer()
}
