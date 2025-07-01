//
//  ContentView.swift
//  edutainmentNumbers
//
//  Created by Victoria Slyunko on 21.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var tableSize: Int = 2
    
    var numberQuestions = [5, 10, 20]
    @State private var chosenAmount: Int = 5
    
    @State private var answer: String = ""
    @State private var currentQuestion: (left: Int, right: Int) = (2, 2)
    
    @State private var questionsAsked: Int = 0
    @State private var score: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("MULTIPLICATION TABLE GAME")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.cyan)
                    .multilineTextAlignment(.center)
                
                
                HStack {
                    Text("Multiplication table up to: \(tableSize)")
                    Stepper(value: $tableSize, in: 2...12) { }
                }
                .padding()
                
                Text("How many questions you want to be asked?")
                Picker("Number of questoins", selection: $chosenAmount) {
                    ForEach(0..<numberQuestions.count, id: \.self) {
                        Text("\(self.numberQuestions[$0])")
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom)
                
                Spacer()
                Button("PLAY") {
                    resetGame()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.cyan)
                .foregroundColor(.primary)
                .cornerRadius(15)
                .shadow(radius: 5)
                
                Spacer()
                
                HStack {
                    Text("\(currentQuestion.left) x \(currentQuestion.right)")
                        .font(.title2)
                    Spacer()
                    TextField("Answer", text: $answer)
                        .keyboardType(.numberPad)
                        .frame(width: 100)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                    Button("CHECK") {
                        checkAnswer()
                    }
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.gray)
                .foregroundColor(.primary)
                .cornerRadius(15)
                .shadow(radius: 5)
                
                Spacer()

                Text("Score: \(score)")
            }
            .padding()
        }
    }
    
    func checkAnswer() {
        // Try to convert the user's input to an Int
        guard let userAnswer = Int(answer) else {
            // Handle invalid input if needed (like showing an alert)
            return
        }

        let correctAnswer = currentQuestion.left * currentQuestion.right

        if userAnswer == correctAnswer {
            print("Correct!")
            score += 1
            // Add point, go to next question, etc.
        } else {
            print("Wrong!")
            score -= 1
            // Subtract point, etc.
        }

        // Reset input
        answer = ""
        questionsAsked += 1

        if questionsAsked < chosenAmount {
            newQuestion()
        } else {
            //finish the game and show points
        }
    }
    
    func newQuestion() {
        currentQuestion = (left: Int.random(in: 2...tableSize), right: Int.random(in: 0...12))
    }
    
    func resetGame() {
        score = 0
        questionsAsked = 0
        answer = ""
        newQuestion()
    }
}

#Preview {
    ContentView()
}
