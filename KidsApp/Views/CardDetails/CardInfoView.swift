//
//  CardInfoView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct CardInfoView: View {
    @EnvironmentObject var viewModel: AuthManager
    
    var body: some View {
        VStack(alignment: .leading) {
            ProgressView()
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(viewModel.card?.balance ?? 0, specifier: "%.2f")")
                    .font(.system(size: 40, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .foregroundColor(.white)
                Text("₴")
                    .font(.system(size: 40, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .foregroundColor(ColorConstants.secondary)
            }
            
        }
    }
}
