//
//  ContentView.swift
//  LetThemRoll
//
//  Created by Victoria Slyunko on 14/7/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    let diceTypes = [4, 6, 8, 10, 12, 20, 100]

    @AppStorage("selectedDiceType") var selectedDiceType = 6
    @AppStorage("numberToRoll") var numberToRoll = 4
    
    @State private var currentResult = DiceResult(type: 0, number: 0)
    
    let columns: [GridItem] = [
        .init(.adaptive(minimum: 60))
    ]
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var stoppedDice = 0
    
    let savePath = URL.documentsDirectory.appending(path: "SavedRolls.json")
    @State private var savedResults = [DiceResult]()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Type of dice", selection: $selectedDiceType) {
                        ForEach(diceTypes, id: \.self) { type in
                            Text("D\(type)")
                        }
                    }
                    .pickerStyle(.segmented)

                    Stepper("Number of dice: \(numberToRoll)", value: $numberToRoll, in: 1...20)

                    Button("Roll them!", action: rollDice)
                } footer: {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<currentResult.rolls.count, id: \.self) { rollNumber in
                            Text(String(currentResult.rolls[rollNumber]))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundStyle(.black)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(radius: 3)
                                .font(.title)
                                .padding(5)
                        }
                    }
                    .accessibilityElement()
                    .accessibilityLabel("Latest roll: \(currentResult.description)")
                }
                .disabled(stoppedDice < currentResult.rolls.count)
                
                if savedResults.isEmpty == false {
                    Section("Previous results") {
                        ForEach(savedResults) { result in
                            VStack(alignment: .leading) {
                                Text("\(result.number) x D\(result.type)")
                                    .font(.headline)
                                Text(result.description)
                            }
                            .accessibilityElement()
                            .accessibilityLabel("\(result.number) D\(result.type), \(result.description)")
                        }
                    }
                }
            }
            .navigationTitle("High Rollers")
            .onReceive(timer) { date in
                updateDice()
            }
            .onAppear(perform: load)
            .sensoryFeedback(.impact, trigger: savedResults.count)
        }
    }
    
    func rollDice() {
        currentResult = DiceResult(type: selectedDiceType, number: numberToRoll)
        
        if accessibilityVoiceOverEnabled {
            stoppedDice = numberToRoll
            savedResults.insert(currentResult, at: 0)
            save()
        } else {
            stoppedDice = -20
        }    }
    
    func updateDice() {
        guard stoppedDice < currentResult.rolls.count else { return }

        for i in stoppedDice..<numberToRoll {
            if i < 0 { continue }
            currentResult.rolls[i] = Int.random(in: 1...selectedDiceType)
        }

        stoppedDice += 1
        
        if stoppedDice == numberToRoll {
            savedResults.insert(currentResult, at: 0)
            save()
        }
    }
    
    func load() {
        if let data = try? Data(contentsOf: savePath) {
            if let results = try? JSONDecoder().decode([DiceResult].self, from: data) {
                savedResults = results
            }
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(savedResults) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}

#Preview {
    ContentView()
}
