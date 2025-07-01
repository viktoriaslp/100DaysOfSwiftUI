//
//  ContentView.swift
//  unitConversor
//
//  Created by Victoria Slyunko on 07.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var valueToConvert: Double = 0
    @State private var sourceUnit: String = "milliliters"
    @State private var targetUnit: String = "liters"
    
    let units: [String] = ["milliliters", "liters", "cups", "pints", "gallons"]

    var convertValue: Double {
        // Primero pasamos todo a mililitros como unidad base
        let valueInMilliliters: Double
        
        switch sourceUnit {
        case "milliliters": valueInMilliliters = valueToConvert
        case "liters": valueInMilliliters = valueToConvert * 1000
        case "cups": valueInMilliliters = valueToConvert * 240
        case "pints": valueInMilliliters = valueToConvert * 473.176
        case "gallons": valueInMilliliters = valueToConvert * 3785.41
        default: valueInMilliliters = 0
        }
        
        switch targetUnit {
        case "milliliters": return valueInMilliliters
        case "liters": return valueInMilliliters / 1000
        case "cups": return valueInMilliliters / 240
        case "pints": return valueInMilliliters / 473.176
        case "gallons": return valueInMilliliters / 3785.41
        default: return 0
        }
        
    }
    
    var body: some View {
        Form {
            Section("Select input unit") {
                Picker("Input unit", selection: $sourceUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("Enter value") {
                TextField("Value", value: $valueToConvert, format: .number)
            }
            
            Section("Select output unit") {
                Picker("Output unit", selection: $targetUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("Result") {
                Text(convertValue.formatted())
            }
        }
    }
}

#Preview {
    ContentView()
}
