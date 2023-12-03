//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by JOY JAIN on 03/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var appAnswers = ["Rock", "Paper", "Scissors"] // The possible options the app/computer opponent can choose
    @State private var appChoice = Int.random(in:0...2) // Used to randomize appChoice
    @State private var mustWin = Bool.random() // Decides whether the user should win or lose
    
    
    @State private var questionCounter = 1 // Tracks how many questions there've been
    @State private var userScore = 0 // Tracks the users score
    
    @State private var scoreAlert = "" // This will be displayed in an alert when an answer is selected and is set in the answerSelected function
    
    @State private var showScore = false // Used to trigger alert after an answer is selected
    @State private var gameOver = false // Used to trigger an alert after the final question
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color.indigo, location: 0.3),
                .init(color: Color.mint, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 300)
            .ignoresSafeArea()
            VStack {
                Text("Brain Training")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                    .frame(height: 100)
                Text("Question \(questionCounter) of 10")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                Spacer()
                Text("Score: \(userScore)")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
            }
            
            VStack {
                Spacer()
                Spacer()
                Text(mustWin ? "You must win!" : "You must lose!"  )
                    .frame(height: 70)
                    .font(.largeTitle.bold().smallCaps())
                    .foregroundColor(.indigo)
                    .background(.thinMaterial)
                    .padding()
                
                Text("The computer chose: ")
                    .frame(height: 40)
                    .font(.title.bold().smallCaps())
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                Image("\(appAnswers[appChoice])")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Choose your move:")
                    .font(.title.bold().smallCaps())
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            checkAnswer(number)
                        } label: {
                            Image("\(appAnswers[number])")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                Spacer()
            }
        }
        .alert(scoreAlert, isPresented: $showScore) {
            Button("Next question", action: newQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        
        .alert("Game finished!", isPresented: $gameOver) {
            Button("Restart game", action: restartGame)
        } message: {
            Text("You finished the game with a score of \(userScore).")
        }
    }
    
    func checkAnswer(_ userChoice: Int) {
        let requirementWinLose = mustWin ? "win" : "lose"
        let correctAnswerAlert = "Correct! You had to \(requirementWinLose). You chose \(appAnswers[userChoice]) and the computer chose \(appAnswers[appChoice])"
        let incorrectAnswerAlert = "Incorrect! You had to \(requirementWinLose). You chose \(appAnswers[userChoice]) and the computer chose \(appAnswers[appChoice])"
        
        if mustWin {
            if userChoice == 0 && appChoice == 0 || userChoice == 0 && appChoice == 1 {
                scoreAlert = incorrectAnswerAlert
                userScore-=1
            } else if userChoice == 0 && appChoice == 2 {
                scoreAlert = correctAnswerAlert
                userScore+=1
            } else if userChoice == 1 && appChoice == 1 || userChoice == 1 && appChoice == 2 {
                scoreAlert = incorrectAnswerAlert
                userScore-=1
            } else if userChoice == 1 && appChoice == 0 {
                scoreAlert = correctAnswerAlert
                userScore+=1
            } else if userChoice == 2 && appChoice == 0 || userChoice == 2 && appChoice == 2 {
                scoreAlert = incorrectAnswerAlert
                userScore-=1
            } else if userChoice == 2 && appChoice == 1 {
                scoreAlert = correctAnswerAlert
                userScore+=1
            }
        } else {
            if userChoice == 0 && appChoice == 0 || userChoice == 0 && appChoice == 2 {
                scoreAlert = incorrectAnswerAlert
                userScore-=1
            } else if userChoice == 0 && appChoice == 1 {
                scoreAlert = correctAnswerAlert
                userScore+=1
            } else if userChoice == 1 && appChoice == 0 || userChoice == 1 && appChoice == 1 {
                scoreAlert = incorrectAnswerAlert
                userScore-=1
            } else if userChoice == 1 && appChoice == 2 {
                scoreAlert = correctAnswerAlert
                userScore+=1
            } else if userChoice == 2 && appChoice == 1 || userChoice == 2 && appChoice == 2 {
                scoreAlert = incorrectAnswerAlert
                userScore-=1
            } else if userChoice == 2 && appChoice == 0 {
                scoreAlert = correctAnswerAlert
                userScore+=1
            }
        }
        
        showScore = true
        trackQuestions()
        
    }
    
    func trackQuestions() {
        if questionCounter == 10 {
            gameOver = true
            showScore = false
        }
    }
    
    func newQuestion() {
        appChoice = Int.random(in: 0...2)
        mustWin.toggle()
        questionCounter+=1
    }
    
    func restartGame() {
        appChoice = Int.random(in: 0...2)
        mustWin.toggle()
        userScore = 0
        questionCounter = 1
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

