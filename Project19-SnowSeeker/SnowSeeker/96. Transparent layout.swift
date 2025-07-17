//
//  96. Transparent layout.swift
//  SnowSeeker
//
//  Created by Victoria Slyunko on 15/7/25.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct Transparent_layout: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
        
//        ViewThatFits {
//            Rectangle()
//                .frame(width: 500, height: 200)
//
//            Circle()
//                .frame(width: 200, height: 200)
//        }
    }
}

#Preview {
    Transparent_layout()
}
