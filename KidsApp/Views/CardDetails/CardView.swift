//
//  CardView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var viewModel: AuthManager
//    @Binding var showCardNumber: Bool
    
    @EnvironmentObject var auth: AuthManager
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(ColorConstants.gradient)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text((auth.user?.firstName.uppercased() ?? "") + " " + (auth.user?.lastName.uppercased() ?? ""))
                            .font(.system(size: 16, weight: .heavy))
                            .kerning(5.0)
                            .lineLimit(nil)
                        Text("KID")
                            .font(.system(size: 14, weight: .semibold))
                            .kerning(2.0)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(auth.card?.company.uppercased() ?? "")
                            .font(.system(size: 28, weight: Font.Weight.heavy))
                            .italic()

                        Text("DEBIT")
                            .font(.system(size: 14, weight: .semibold))
                            .kerning(2.0)
                    }
                }
                
                Spacer()
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(viewModel.card?.balance ?? 0, specifier: "%.2f")")
                        .font(.system(size: 25, weight: Font.Weight.bold, design: Font.Design.rounded))
                        .foregroundColor(.white)
                    Text("₴")
                        .font(.system(size: 25, weight: Font.Weight.bold, design: Font.Design.rounded))
                        .foregroundColor(ColorConstants.secondary)
                        
                    Spacer()
                    
                    Text(viewModel.card?.expirationDate ?? "")
                        .kerning(3.0)
                        .font(.system(size: 16, weight: .heavy))
                }
                
                Spacer()
                
                HStack {
//                    if showCardNumber {
//                        HStack {
//                            Text(auth.card?.number.applyCardPattern() ?? "")
//                                .kerning(5.0)
//                                .font(.system(size: 16, weight: .semibold))
//                        }
//                    } else {
//                        HStack {
//                            ForEach(0..<3) { i in
//                                Text("**** ")
//                                    .kerning(5.0)
//                                    .font(.system(size: 16, weight: .semibold))
//                            }
//
//                            Text(auth.card?.getLastFourDigit() ?? "")
//                                .kerning(5.0)
//                                .font(.system(size: 16, weight: .semibold))
//                        }
//                    }
//
//                    Spacer()
//
//                    Image(systemName: "dot.radiowaves.right")
                    Text(auth.card?.number.applyCardPattern() ?? "")
                        .kerning(5.0)
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    
                    Image(systemName: "dot.radiowaves.right")
                }
            }
            .padding(.all, 40)
        }
        .shadow(color: Color("buttonShadow"), radius: 30, x: 10, y: 10)
        .foregroundColor(.white)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

