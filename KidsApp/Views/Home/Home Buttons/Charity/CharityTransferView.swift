//
//  CharityTransferView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 02.05.2022.
//

import SwiftUI

struct CharityTransferView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
    @ObservedObject var viewModel: CharityTransferViewModel
    @Namespace var animation
    
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
    
    private var amountInput: some View {
        VStack {
            CustomTF(image: "banknote.fill", title: "AMOUNT IN ₴", value: $viewModel.amountToWithdraw, animation: animation)
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
                    .opacity(!viewModel.isFiledEmpty ? 1 : 0.6)
                }
                .disabled(viewModel.isFiledEmpty)
            }
        }
        .padding()
        .padding(.trailing)
    }
}

struct CharityTransferView_Previews: PreviewProvider {
    static var previews: some View {
        CharityTransferView(viewModel: CharityTransferViewModel())
    }
}
