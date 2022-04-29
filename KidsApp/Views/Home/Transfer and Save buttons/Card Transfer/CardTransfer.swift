//
//  CardTransfer.swift
//  KidsApp
//
//  Created by Oleh Haidar on 18.04.2022.
//

import SwiftUI

struct CardTransfer: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
    @ObservedObject var viewModel: CardTransferViewModel
    @Namespace var animation
    @FocusState var amountIsFocused: Bool
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                cardView
                cardNumberAndAmount
                sendButton
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            if viewModel.isLoading {
                LoadingTransfer()
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
                CardView()
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
            CustomTF(image: "creditcard.fill", title: "CARD NUMBER TO WITHDRAW", value: $viewModel.cardNumberToWithdraw, animation: animation)
                .keyboardType(.numberPad)
                .focused($amountIsFocused)
            CustomTF(image: "banknote.fill", title: "AMOUNT IN ₴", value: $viewModel.amountToWithdraw, animation: animation)
                .keyboardType(.numberPad)
                .focused($amountIsFocused)
        }
    }
    
    private var sendButton: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Button(action: {
                    viewModel.isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    HStack(spacing: 10) {
                        Text("SEND FUNDS")
                            .fontWeight(.heavy)
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .modifier(CustomButtonModifier())
                    .opacity(!viewModel.isFiledsEmpty ? 1 : 0.6)
                }
                .disabled(viewModel.isFiledsEmpty)
            }
        }
        .padding()
        .padding(.trailing)
    }
}

struct CardTransfer_Previews: PreviewProvider {
    static var previews: some View {
        CardTransfer(viewModel: CardTransferViewModel())
    }
}
