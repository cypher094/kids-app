//
//  SavingMoneyView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 18.04.2022.
//

import SwiftUI

struct SavingMoneyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                headerView
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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
                
                Text("Saving funds")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Here you can save money and achive your goals!")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
}

struct SavingMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        SavingMoneyView()
    }
}