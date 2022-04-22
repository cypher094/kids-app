//
//  TransferSaveView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 18.04.2022.
//

import SwiftUI

struct TransferSaveView: View {
    
    @State var showTransfer = false
    @State var showSaving = false
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                NavigationLink(destination: CardTransfer(), isActive: $showTransfer) {
                    Button(action: {
                        showTransfer = true
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
                NavigationLink(destination: SavingMoneyView(), isActive: $showSaving) {
                    Button(action: {
                        showSaving = true
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
        }
        .padding()
    }
}


