//
//  81.03.Adding Swift package dependencies in Xcode.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import SamplePackage
import SwiftUI

struct _1_03_Adding_Swift_package_dependencies_in_Xcode: View {
    let possibleNumbers = 1...60
    
    var result: String {
       let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    var body: some View {
        Text(result)
    }
}

#Preview {
    _1_03_Adding_Swift_package_dependencies_in_Xcode()
}
