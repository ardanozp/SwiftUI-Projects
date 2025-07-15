//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by ardano on 14.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var wrongDescription = ""
    
    @State private var userScore = 0
    
    @State private var questionCount = 0
    @State private var isGameDone = false


    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            wrongDescription = ""
        } else {
            scoreTitle = "Wrong"
            wrongDescription = "That’s the flag of \(countries[number])."
        }
        
        questionCount += 1

           if questionCount == 8 {
               isGameDone = true
           } else {
               showingScore = true
           }
}
    
    func askQuestion () {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        userScore = 0
        questionCount = 0
        isGameDone = false
        askQuestion()
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.2),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 300, endRadius: 700)
                .ignoresSafeArea()
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 25) {
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
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 9)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(wrongDescription.isEmpty ? "Your score is \(userScore)" : "\(wrongDescription)\nYour score is \(userScore)")")
        }
        
        .alert("Game Over", isPresented: $isGameDone) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("You answered 8 questions.\nYour final score is \(userScore).")
        }
        
    }
}

#Preview {
    ContentView()
}
