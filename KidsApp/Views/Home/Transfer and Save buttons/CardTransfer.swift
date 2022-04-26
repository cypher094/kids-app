//
//  CardTransfer.swift
//  KidsApp
//
//  Created by Oleh Haidar on 18.04.2022.
//

import SwiftUI

struct CardTransfer: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: AuthManager
    @Namespace var animation
    @State var isLoading = false
    @State var showCardNumber: Bool = false
    @State var cardNumberToWithdraw = ""
    @State var amountToWithdraw = ""
    
    var body: some View {
        NavigationView {
            VStack {
                headerView
                cardView
                cardNumberAndAmount
                sendButton
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            ZStack {
                if isLoading {
                    LoadingSuccess()
                }
            }
        }
        .navigationBarHidden(true)
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
                
                Text("Withdraw funds")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("From card")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var cardView: some View {
        VStack {
            VStack {
                CardView(showCardNumber: $showCardNumber)
                    .onLongPressGesture(minimumDuration: 0.1) {
                        withAnimation {
                            showCardNumber = true
                        }
                    }
            }
            .frame(height: 240)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("To card")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                }
                Spacer()
            }
            .padding()
            .padding(.leading)
        }
    }
    
    private var cardNumberAndAmount: some View {
        VStack {
            CustomTF(image: "creditcard.fill", title: "CARD NUMBER TO WITHDRAW", value: $cardNumberToWithdraw, animation: animation)
                .keyboardType(.numberPad)
            CustomTF(image: "banknote.fill", title: "AMOUNT IN ₴", value: $amountToWithdraw, animation: animation)
                .keyboardType(.numberPad)
        }
    }
    
    private var sendButton: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Button(action: {
                    isLoading = true
                    guard !cardNumberToWithdraw.isEmpty, !amountToWithdraw.isEmpty else { return }
                    
                }) {
                    HStack(spacing: 10) {
                        Text("SEND FUNDS")
                            .fontWeight(.heavy)
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .modifier(CustomButtonModifier())
                }
            }
        }
        .padding()
        .padding(.trailing)
    }
}

struct CardTransfer_Previews: PreviewProvider {
    static var previews: some View {
        CardTransfer()
    }
}
