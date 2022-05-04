//
//  CurrencyRatesListRow.swift
//  KidsApp
//
//  Created by Oleh Haidar on 29.04.2022.
//

import SwiftUI

struct CurrencyRatesListRow: View {
    let string: String
    let currency: String

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ZStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 30, weight: .heavy))
//                        .foregroundColor(Color("purpleColor"))
                        .foregroundColor(ColorConstants.secondary)
                }
                
                HStack {
                    Text("\(string) \(currency)")
                }
                .padding(.leading, 10)
                
                Spacer()
            }
            
            Divider()
                .background(ColorConstants.secondary)
                .padding(.leading, 60)
                .padding(.bottom, 8)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}
