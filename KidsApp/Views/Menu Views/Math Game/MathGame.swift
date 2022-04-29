//
//  MathGame.swift
//  KidsApp
//
//  Created by Oleh Haidar on 18.04.2022.
//

import SwiftUI

struct MathGame: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var correctAnswerLoading = false
    @State var wrongAnswerLoading = false
    @State private var correctAnswer = 0
    @State private var choiceArray : [Int] = [0, 1, 2, 3]
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var difficulty = 1000
    @State private var score = 0
    
    var animationEnded: Bool {
        correctAnswerLoading || wrongAnswerLoading
    }
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                mathExample
                bubbles
                scoreView
                Spacer()
            }
            .onAppear(perform: generateAnswers)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            if correctAnswerLoading {
                LoadingCorrect()
            }
            if wrongAnswerLoading {
                LoadingWrong()
            }
        }
    }

    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)
                
                Text("Math game")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Solve equation to get some points.")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var scoreView: some View {
        HStack {
            Text("Score: \(score)")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.primary)
        }
        .padding(.top, 70)
    }
    
    private var mathExample: some View {
        HStack {
            Text("\(firstNumber) + \(secondNumber)")
                .font(.system(size: 40, weight: .heavy))
                .foregroundColor(.primary)
        }
        .padding(.top, 50)
    }
    
    private var bubbles: some View {
        VStack {
            HStack {
                ForEach(0..<2) {index in
                    Button {
                        answerIsCorrect(answer: choiceArray[index])
                        generateAnswers()
                    } label: {
                        AnswerButton(number: choiceArray[index])
                    }
                    .disabled(animationEnded)
                }
            }
            
            HStack {
                ForEach(2..<4) {index in
                    Button {
                        answerIsCorrect(answer: choiceArray[index])
                        generateAnswers()
                    } label: {
                        AnswerButton(number: choiceArray[index])
                    }
                    .disabled(animationEnded)
                }
            }
        }
    }
    
    func answerIsCorrect(answer: Int){
        if answer == correctAnswer {
            self.score += 1
            correctAnswerLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                correctAnswerLoading = false
            }
        } else {
            self.score -= 1
            wrongAnswerLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                wrongAnswerLoading = false
            }
        }
    }
    
    
    func generateAnswers(){
        firstNumber = Int.random(in: 0...(difficulty/2))
        secondNumber = Int.random(in: 0...(difficulty/2))
        var answerList = [Int]()
        
        correctAnswer = firstNumber + secondNumber
        
        for i in 0...2 {
            answerList.append(Int.random(in: 0...difficulty))
        }
        
        answerList.append(correctAnswer)
        
        choiceArray = answerList.shuffled()
    }
}

struct AnswerButton: View {
    var number : Int
    
    var body: some View {
        Text("\(number)")
            .frame(width: 120, height: 120)
            .font(.system(size: 40, weight: .bold))
            .foregroundColor(Color.white)
            .modifier(CustomButtonModifier())
            .clipShape(Circle())
            .padding()
    }
}

struct MathGame_Previews: PreviewProvider {
    static var previews: some View {
        MathGame()
    }
}
