//
//  AddPocketMoneyView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 20.04.2022.
//

import SwiftUI

struct AddPocketMoneyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
    @ObservedObject var viewModel: AddPocketMoneyViewModel
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                pocketMoneyAnimation
                inputs
                addPocketMoney
                Spacer()
            }
            if viewModel.isLoading {
                LoadingCorrect()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)
                
                Text("Add pocket money")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Let's start save your money!")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
        }
        .padding(.top)
    }
    
    private var pocketMoneyAnimation: some View {
        VStack(alignment: .center) {
            LottieView(fileName: "pocketMoney")
                .frame(width: 500, height: 500)
                .padding(.bottom, -100)
                .padding(.top, -100)
        }
    }
    
    private var inputs: some View {
        VStack {
            AmountTF(image: "banknote.fill", title: "AMOUNT IN ₴", value: $viewModel.amount, animation: animation)
                .keyboardType(.phonePad)
            CustomTF(image: "rectangle.and.pencil.and.ellipsis", title: "MY GOAL IS", value: $viewModel.goalText, animation: animation)
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    private var addPocketMoney: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    viewModel.isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        auth.addPocketMoney(name: viewModel.goalText, goalAmount: viewModel.amount)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    HStack(spacing: 10) {
                        Text("ADD POCKET MONEY")
                            .fontWeight(.heavy)
                    }
                    .modifier(CustomButtonModifier())
                    .opacity(!viewModel.isFiledsEmpty ? 1 : 0.6)
                }
                .disabled(viewModel.isFiledsEmpty)
            }
        }
        .padding()
        .padding(.trailing, 40)
    }
}
