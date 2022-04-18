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
            
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("₴")
                    .font(.system(size: 30, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .foregroundColor(ColorConstants.secondary)
                Text(viewModel.user?.balance ?? "")
                    .font(.system(size: 40, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .foregroundColor(.white)
                    .padding(.leading, 10)
//                Text(".90")
//                    .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
//                    .foregroundColor(ColorConstants.secondary)
            }
        }
    }
}
