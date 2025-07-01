//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Victoria Slyunko on 07.04.2025.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}
    

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    @State private var scoreCount = 0
    @State private var numberOfQuestions = 8
    @State private var gameOver = false
    
    //Para los efectos visuales
    @State private var selectedFlagIndex: Int? = nil
    
    var body: some View {
        ZStack {
            // Color degradado desde arriba hacia abajo
            //LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            //    .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center:.top, startRadius: 200, endRadius:700)
            .ignoresSafeArea()
                
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        .rotation3DEffect(
                            selectedFlagIndex == number ? .degrees(360) : .degrees(0),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .opacity(selectedFlagIndex == nil || selectedFlagIndex == number ? 1 : 0.25)
                        .saturation(selectedFlagIndex == nil || selectedFlagIndex == number ? 1 : 0)
                    }
                }
                //esto añade el cuadrado traslucido
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreCount)")
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreCount)")
        }
        
        .alert("The end", isPresented: $gameOver) {
            Button("Play again", action: resetGame)
        } message: {
            Text("Your score is \(scoreCount)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreCount = scoreCount + 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number]) "
            scoreCount = scoreCount - 1
        }
        
        withAnimation {
            selectedFlagIndex = number
        }
        showingScore = true
        numberOfQuestions -= 1
        
        if numberOfQuestions == 0 {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedFlagIndex = nil

    }
    
    func resetGame() {
        scoreCount = 0
        numberOfQuestions = 8
        askQuestion()
    }
}

#Preview {
    ContentView()
}
