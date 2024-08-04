//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by kqDevs on 17/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var actualScore = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var gameOver = false
    @State private var finalScore = 0
    @State private var questionNumber = 0
    
    struct FlagImage: View {
        var country: String
        
        var body: some View {
            Image(country)
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            //LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)>
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.38)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    //.font(.largeTitle.weight(.bold))
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            //.foregroundStyle(.secondary)
                            //.shadow(color: .black, radius: 5)
                    }
                
                    ForEach(0..<3) { number in
                        Button {
                            questionNumber = flagTapped(number, questionNumber)
                        } label: {
                            FlagImage(country: countries[number])
                            /*
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                             */
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(actualScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                if gameOver {
                    Text("Question 8/8")
                        .foregroundStyle(.white)
                        .font(.title2.italic())
                }else {
                    Text("Question \(questionNumber + 1)/8")
                        .foregroundStyle(.white)
                        .font(.title2.italic())
                }
                    
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(actualScore)")
        }
        
        .alert(scoreTitle, isPresented: $gameOver) {
            Button("Restart game", action: restartGame)
        } message: {
            Text("Your final score is \(finalScore)")
        }
    }
    
    func flagTapped(_ number: Int, _ questionNumber: Int) -> Int {
        var questionNum = questionNumber
        questionNum += 1
        
        if questionNum < 8 {
            if number == correctAnswer {
                scoreTitle = "Correct! 🎉"
                actualScore += 1
            }else {
                scoreTitle = """
                                 Wrong! 🚫
                             That's the flag of \(countries[number])
                             """
                //scoreTitle = "Wrong! That's the flag of \(countries[number])"
            }
            
            showingScore = true
        }else {
            if number == correctAnswer {
                scoreTitle = "Correct! 🎉"
                actualScore += 1
            }else {
                scoreTitle = """
                                 Wrong! 🚫
                             That's the flag of \(countries[number])
                             """
                //scoreTitle = "Wrong! That's the flag of \(countries[number])"
            }
            
            finalScore = actualScore
            gameOver = true
            questionNum = 0
        }
        
        return questionNum
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        actualScore = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
