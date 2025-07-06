//
//  80.02.Controlling image interpolation in SwiftU.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import SwiftUI

struct _0_02_Controlling_image_interpolation_in_SwiftU: View {
    var body: some View {
        Image(.example)
            .interpolation(.none) //  Disable image smoothing when scaling
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}

#Preview {
    _0_02_Controlling_image_interpolation_in_SwiftU()
}
