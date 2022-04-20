//
//  CardView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var viewModel: AuthManager
    @Binding var showCardNumber: Bool
    
    let card: CreditCard
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(ColorConstants.gradient)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(card.name.uppercased())
                            .font(.system(size: 16, weight: .heavy))
                            .kerning(5.0)
                            .lineLimit(nil)
                        Text(card.type.rawValue.uppercased())
                            .font(.system(size: 14, weight: .semibold))
                            .kerning(2.0)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(card.company.uppercased())
                            .font(.system(size: 28, weight: Font.Weight.heavy))
                            .italic()

                        Text("DEBIT")
                            .font(.system(size: 14, weight: .semibold))
                            .kerning(2.0)
                    }
                }
                
                Spacer()
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("₴")
                        .font(.system(size: 18, weight: Font.Weight.bold, design: Font.Design.rounded))
                        .foregroundColor(ColorConstants.secondary)
                    Text(viewModel.user?.balance ?? "")
                        .font(.system(size: 25, weight: Font.Weight.bold, design: Font.Design.rounded))
                        .foregroundColor(.white)
                        
                    Spacer()
                    
                    Text("10/24")
                        .kerning(3.0)
                        .font(.system(size: 16, weight: .semibold))
                }
                
                Spacer()
                
                HStack {
                    if showCardNumber {
                        HStack {
                            Text(card.number.applyCardPattern())
                                .kerning(5.0)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    } else {
                        HStack {
                            ForEach(0..<3) { i in
                                Text("**** ")
                                    .kerning(5.0)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            
                            Text(card.getLastFourDigit())
                                .kerning(5.0)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }

                    Spacer()
                    
                    Image(systemName: "dot.radiowaves.right")
                }
            }
            .padding(.all, 40)
        }
        .foregroundColor(.white)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

