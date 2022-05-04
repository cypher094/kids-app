//
//  SavingMoneyEditView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 04.05.2022.
//

import SwiftUI

struct SavingMoneyEditView: View {
    @EnvironmentObject var auth: AuthManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Namespace var animation
    @State var isLoading = false
    @State var amount = ""
    @State var goalText = ""
    var pocket: PocketMoney
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                pocketMoneyAnimation
                inputs
                editPocketMoney
                Spacer()
                
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            if isLoading {
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
                
                Text("Edit pocket money")
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
            CustomTF(image: "banknote.fill", title: "AMOUNT IN ₴", value: $amount, animation: animation)
                .keyboardType(.phonePad)
            CustomTF(image: "rectangle.and.pencil.and.ellipsis", title: "MY GOAL IS", value: $goalText, animation: animation)
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    private var editPocketMoney: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        auth.updatePocketMoney(updatePocket: pocket, updatedName: goalText, updatedAmount: amount)
                        
                    }
                }) {
                    HStack(spacing: 10) {
                        Text("EDIT POCKET MONEY")
                            .fontWeight(.heavy)
                    }
                    .modifier(CustomButtonModifier())
                }
            }
        }
        .padding()
        .padding(.trailing, 40)
    }
}
