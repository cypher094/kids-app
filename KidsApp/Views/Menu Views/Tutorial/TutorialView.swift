//
//  TutorialView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 28.09.2021.
//

import SwiftUI

struct OnBoardingStep {
    let lottie: String
    let title: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingStep(lottie: "kidView1", title: "Clover - App for kids", description: "We will help you dive into the banking industry."),
    OnBoardingStep(lottie: "kidView3", title: "Credit card", description: "We will be able to send and receive funds from other people."),
    OnBoardingStep(lottie: "pig", title: "Reach the goal", description: "You could use pocket money to save money."),
    OnBoardingStep(lottie: "kidView2", title: "Have a problem?", description: "Write to our chat bot then our agent will contact with you."),
    OnBoardingStep(lottie: "kidView4", title: "Welcome to Clover", description: "Try it yourself.")
]

class TutorialViewModel: ObservableObject {
    @Published var isNextScreenPresenting: Bool = false
}

struct TutorialView: View {
    @ObservedObject var viewModel: TutorialViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var currentStep = 0
    
//    init() {
//        UIScrollView.appearance().bounces = false
//    }
    
    var body: some View {
        VStack {
            headerButtons
            lottieView
            counter
            nextButton
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private var lottieView: some View {
        VStack {
            TabView(selection: $currentStep) {
                ForEach(0..<onBoardingSteps.count) { value in
                    VStack(spacing: 20) {
                        LottieView(fileName: onBoardingSteps[value].lottie)
                            .frame(width: 350, height: 350)
                        
                        Text(onBoardingSteps[value].title)
                            .font(.system(size: 40, weight: .heavy))
                            .foregroundColor(.primary)
                        
                        Text(onBoardingSteps[value].description)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    .tag(value)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
    private var counter: some View {
        HStack {
            ForEach(0..<onBoardingSteps.count) { value in
                if value == currentStep {
                    Rectangle()
                        .frame(width: 20, height: 10)
                        .cornerRadius(10)
                        .foregroundColor(Color("purpleColor"))
                } else {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color.gray)
                }
            }
        }
        .padding()
    }
    
    private var headerButtons: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        self.currentStep = onBoardingSteps.count - 1
                    }) {
                        Text(currentStep == 4 ? "" : "Skip")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("purpleColor"))
                            .padding()
                    }
                }
                
                Text("Tutorial")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("This is information for a better understanding of the application.")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
            }
            
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var nextButton :some View {
        VStack(alignment: .trailing) {
            Button(action: {
                if currentStep < onBoardingSteps.count - 1 {
                    self.currentStep += 1
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                HStack(spacing: 10) {
                    Text(currentStep < onBoardingSteps.count - 1 ? "NEXT" : "GET STARTED!")
                        .fontWeight(.heavy)
                }
                .frame(maxWidth: .infinity)
                .modifier(CustomButtonModifier())
            }
        }
        .padding()
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(viewModel: TutorialViewModel())
    }
}
