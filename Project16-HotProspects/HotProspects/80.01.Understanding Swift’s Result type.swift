//
//  Understanding Swift’s Result type.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import SwiftUI

struct Understanding_Swift_s_Result_type: View {
    @State private var output = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchReading()
            }
    }
    
    // Handling async task result using switch on Task.Result
    // - On success, show how many readings were found
    // - On failure, display the error message
    func fetchReading() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    Understanding_Swift_s_Result_type()
}
