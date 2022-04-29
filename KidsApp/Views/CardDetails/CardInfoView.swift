//
//  CardInfoView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct CardInfoView: View {
    @EnvironmentObject var auth: AuthManager
    
    var body: some View {
        VStack(alignment: .leading) {
            ProgressView()
            cardInfo
            changePinButton
        }
    }
    
    private var cardInfo: some View {
        VStack {
            HStack(alignment: .firstTextBaseline, spacing: 16) {
                Text("\(auth.card?.balance ?? 0, specifier: "%.2f")")
                    .font(.system(size: 40, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .foregroundColor(.white)
                Text("₴")
                    .font(.system(size: 40, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .foregroundColor(ColorConstants.secondary)
            }
            .padding(.bottom, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(ColorConstants.secondary)
                    Text(auth.card?.number.applyCardPattern() ?? "")
                        .font(.system(size: 16, weight: Font.Weight.semibold, design: Font.Design.rounded))
                        .foregroundColor(.white)
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(ColorConstants.secondary)
                    Text(auth.card?.expirationDate ?? "")
                        .font(.system(size: 16, weight: Font.Weight.semibold, design: Font.Design.rounded))
                        .foregroundColor(.white)
                }
                
                HStack {
                    Image(systemName: "building.columns.fill")
                        .foregroundColor(ColorConstants.secondary)
                    Text("Universal Bank")
                        .font(.system(size: 16, weight: Font.Weight.semibold, design: Font.Design.rounded))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 8)
            }
        }
    }
    
    private var changePinButton: some View {
        Button(action: {}) {
            HStack(spacing: 10) {
                Text("CHANGE PIN")
                    .fontWeight(.heavy)
                
                Image(systemName: "arrow.right")
                    .font(.title2)
            }
            .modifier(CustomButtonModifier())
        }
    }
}
