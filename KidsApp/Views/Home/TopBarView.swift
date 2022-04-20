//
//  TopBarView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 23.03.2022.
//

import SwiftUI

struct TopBarView: View {
    @Binding var selecedCard: CreditCard
    @Binding var show: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.spring()) {
                    show = true
                }
            }, label: {
                Image(systemName: "line.horizontal.3.decrease")
            })
            
            Spacer()
            
            Text("HOME")
                .kerning(2.0)
                .bold()
            
            Spacer()
            
            Button(action: {
                withAnimation(.spring()) {
                    selecedCard.selected = true
                }
            }, label: {
                Text("₴")
            })

        }
        .foregroundColor(.white)
        .padding(.top, 64)
        .padding(.bottom, 25)
        .padding(.leading, 25)
        .padding(.trailing, 25)
    }
}
