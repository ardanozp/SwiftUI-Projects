//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by ardano on 20.07.2025.
//

import SwiftUI


struct ContentView: View {

    @State private var appChoice = 0
    @State private var shouldWin = false
    @State private var score = 0
    @State private var round = 0
    
    @State private var showingScore = false
    
    let choices = ["🪨", "📄", "✂️"]
    
    func playerTapped(_ playerChoice: Int) {
        let winningMoves = [1, 2, 0]
        let shouldChoose = shouldWin ? winningMoves[appChoice] : (winningMoves.firstIndex(of: appChoice) ?? 0)
        
        if playerChoice == shouldChoose {
            score += 1
        } else {
            score -= 1
        }
        
        round += 1
        
        if round == 10 {
            showingScore = true
        } else {
            askQuestion()
        }
    }
    
    func askQuestion () {
        appChoice = Int.random(in: 0..<3)
        shouldWin.toggle()
    }
    
    func restartGame() {
        score = 0
        round = 0
        askQuestion()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Score: \(score)")
                Spacer()
                
                Text("App chose: \(choices[appChoice])")
                    .font(.system(size: 40))
                Spacer()
                Spacer()
                
                Text("You need to \(shouldWin ? "WIN" : "LOSE")")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            playerTapped(number)
                        } label: {
                            Text(choices[number])
                                .font(.system(size: 60))
                                .padding()
                        }
                    }
                    
                }
                Spacer()
                Spacer()
                Spacer()
            }
            
        }
        .alert("Game Over", isPresented: $showingScore) {
            Button("Restart Game", action: restartGame)
        } message: {
            Text("Your score is: \(score)")
        }
    }
    
    
}
    
    #Preview {
        ContentView()
    }
    
    
