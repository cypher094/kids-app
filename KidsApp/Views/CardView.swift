//
//  CardView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct CardView: View {
    let card: CreditCard
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(ColorConstants.cardBackground)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(card.name.uppercased())
                            .font(.system(size: 14))
                            .bold()
                            .kerning(5.0)
                        Text(card.type.rawValue.uppercased())
                            .font(.system(size: 14))
                            .bold()
                            .kerning(2.0)
                    }
                    
                    Spacer()
                    
                    Text(card.company.uppercased())
                        .font(.system(size: 28, weight: Font.Weight.heavy))
                        .italic()
                }
                
                Spacer()
                
                HStack {
                    ForEach(0..<3) { i in
                        Text("****")
                            .kerning(3.0)
                        
                        Spacer()
                    }
                    
                    Text(card.getLastFourDigit())
                        .kerning(3.0)
                }
            }
            .padding(.all, 40)
            
        }
        .foregroundColor(.white)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: creditCards[0])
    }
}
