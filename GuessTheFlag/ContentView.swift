//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alexander Bardi on 3/6/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingRoundEnd = false
    @State private var alertTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Monaco", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var highscore = -1
    //@State private var scoreFinal = 0
    @State private var round = 0
    
    

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                if (highscore != -1) {
                    Text("Highscore: \(highscore)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                }
                
                Spacer()
                
            }
            .padding()
            
        }
        .alert(alertTitle, isPresented: $showingRoundEnd) {
            Button("Play Again", action: newGame)
        } message: {
            Text("Would you like to play again?")
        }
        .alert(alertTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        round += 1
        
        if number == correctAnswer {
            alertTitle = "Correct"
            score += 1
        } else {
            alertTitle = "Whoops, thats the flag of \(countries[number])"
        }
        
        if (round % 8 == 0) {
            if (score == 8) {
                alertTitle = "🎉 Perfect Score! 8/8 🎊"
            } else {
                alertTitle = "Final Score: \(score) / 8"
            }
            showingRoundEnd = true
        } else {
            showingScore = true
        }
    }
    
    func newGame() {
        highscore = max(highscore, score)
        score = 0
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
