//
//  TransferSaveView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 18.04.2022.
//

import SwiftUI

struct TransferSaveView: View {
    @ObservedObject var viewModel: TransferSaveViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                NavigationLink(destination: CardTransfer(viewModel: CardTransferViewModel()), isActive: $viewModel.showTransfer) {
                    Button(action: {
                        viewModel.showTransfer = true
                    }) {
                        HStack(spacing: 10) {
                            Image("cardTransfer")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .font(.system(size: 24, weight: .bold))
                        }
                        .modifier(CustomHomeButton())
                    }
                }
            }
            
            Spacer()
            
            VStack {
                NavigationLink(destination: SavingMoneyView(), isActive: $viewModel.showSaving) {
                    Button(action: {
                        viewModel.showSaving = true
                    }) {
                        HStack(spacing: 10) {
                            Image("piggybank")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .font(.system(size: 24, weight: .bold))
                        }
                        .modifier(CustomHomeButton())
                    }
                }
            }
            
            Spacer()
            
            VStack {
                NavigationLink(destination: CharityView(), isActive: $viewModel.showCharity) {
                    Button(action: {
                        viewModel.showCharity = true
                    }) {
                        HStack(spacing: 10) {
                            Image("charity")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .font(.system(size: 24, weight: .bold))
                        }
                        .modifier(CustomHomeButton())
                    }
                }
            }
            
            Spacer()
            
        }
        .padding()
    }
}


