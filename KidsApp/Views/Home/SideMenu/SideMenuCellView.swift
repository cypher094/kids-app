//
//  SideMenuCellView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 22.03.2022.
//

import SwiftUI

struct SideMenuCellView: View {
    let viewModel: SideMenuViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .font(.title3)
                .frame(width: 40, height: 40)
//                .foregroundColor(Color("purpleColor"))
//                .background(Color.white.clipShape(Circle()))
                       
            Text(viewModel.title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
                
            Spacer()
        }
//        .background(Color("purpleColor").clipShape(Capsule()))
//        .frame(width: getRect().width / 3, alignment: .leading)
//        .frame(maxWidth: getRect().width / 1.5, alignment: .leading)
        .padding()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct SideMenuCellView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuCellView(viewModel: .profile)
    }
}
