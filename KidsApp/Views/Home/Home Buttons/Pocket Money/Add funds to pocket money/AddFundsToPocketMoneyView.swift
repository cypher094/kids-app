//
//  AddFundsToPocketMoney.swift
//  KidsApp
//
//  Created by Oleh Haidar on 06.05.2022.
//

import SwiftUI

struct AddFundsToPocketMoneyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
    @ObservedObject var viewModel: AddFundsToPocketMoneyViewModel
    @Namespace var animation
    let pocket: PocketMoney
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                cardView
                amountInput
                sendButton
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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
                
                Text("Transfering funds")
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
                    Text("To pocket money")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
//                    VStack(alignment: .center) {
//                        LottieView(fileName: "pocketMoney")
//                            .frame(width: 350, height: 350)
//                            .padding(.bottom, -100)
//                            .padding(.top, -50)
//                    }
                }
                Spacer()
            }
            .padding()
            .padding(.leading)
        }
    }
    
    private var amountInput: some View {
        VStack {
            AmountTF(image: "banknote.fill", title: "AMOUNT IN ₴", value: $viewModel.amountToWithdraw, animation: animation)
                .keyboardType(.numberPad)
        }
    }
    
    private var sendButton: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Button(action: {
                    viewModel.isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        auth.addFundsToPocketMoney(updatePocket: pocket, transferedAmount: pocket.transferedAmount + viewModel.amountToWithdraw)
                        auth.updateBalance(balance: auth.card!.balance - viewModel.amountToWithdraw)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    HStack(spacing: 10) {
                        Text("ADD FUNDS TO POCKET")
                            .fontWeight(.heavy)
                    }
                    .modifier(CustomButtonModifier())
                    .opacity(!viewModel.isFiledEmpty ? 1 : 0.6)
                }
                .disabled(viewModel.isFiledEmpty || auth.card!.balance - viewModel.amountToWithdraw < 0)
            }
        }
        .padding()
        .padding(.trailing)
    }
}
