//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Victoria Slyunko on 10.04.2025.
//

import SwiftUI

struct ContentView: View {
    let options: [String] = ["✊ Rock", "🤚 Paper", "✌️Scissors"]
    
    // properties de inicio
    @State private var appChoise = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    // properties al hacer click
    @State private var playerChoice: Int = 0
    @State private var scoreMessage = ""

    
    @State private var scoreCount: Int = 0
    @State private var numberOfGames: Int = 0
    
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    
    // Properies al finalizar el juego
    @State private var endOfGame: Bool = false
        
    var body: some View {
        VStack {
            // Name of the game
            Spacer()
            Text("Brain training game")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.mint)
            
            Spacer()
            
            // Apps choise
            Text("\(options[appChoise])")
                .font(.title)
            
            Text("\(shouldWin ? "Try to WIN this round 💪" : "Try to LOSE this round 😈")")
                .font(.title2)
                .foregroundStyle(shouldWin ? .green : .red)
                .padding()
            
            Spacer()
            
            VStack {
                ForEach(0..<3) { number in
                    Button {
                        playerClicked(number)
                    } label: {
                        Text(options[number])
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.mint)
                            .foregroundColor(.primary)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
            }
           
            Spacer()
            Spacer()
            
            Text("Your score: \(scoreCount)")
            
            Spacer()
        }
        // alerts for points
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: nextGame)
            } message: {
                Text(scoreMessage)
            }
        
        // alerts eng of the game
        .alert("The end", isPresented: $endOfGame) {
            Button("Play again", action: resetGame)
        } message: {
            Text("Your score is \(scoreCount) out of \(numberOfGames)")
        }
    }
    
    // this function receive the number of the array player clicked on
    func playerClicked(_ number: Int) {
        let winsAgainst = [2, 0, 1] //
        
        let didWin = winsAgainst[number] == appChoise
          let isCorrect = shouldWin ? didWin : !didWin

        if isCorrect {
            scoreCount += 1
            scoreTitle = "Correct!"
            scoreMessage = "You got it right! 🎉"
        } else {
            scoreCount -= 1
            scoreTitle = "Wrong!"
            scoreMessage = "Oops, that was \(options[appChoise]). 😢"
        }
            
        numberOfGames += 1

        if numberOfGames == 10 {
            endOfGame = true
        } else {
            showingScore = true
        }
    }
    
    func nextGame() {
        appChoise = Int.random(in: 0..<3)
        shouldWin.toggle()
        showingScore = false
    }
    
    func resetGame() {
        scoreCount = 0
        numberOfGames = 0
        nextGame()
    }
}

#Preview {
    ContentView()
}
