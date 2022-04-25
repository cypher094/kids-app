//
//  SideMenuHeaderView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 22.03.2022.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @EnvironmentObject var auth: AuthManager
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("img2")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .padding(.bottom, 16)
                
                Spacer()
                
                xmarkButton
            }
            
            HStack {
                Text("\(auth.user?.firstName ?? "") \(auth.user?.lastName ?? "")")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
            }
            

            Spacer()
        }
        
        .padding()
    }
    
    private var xmarkButton: some View {
        Button(action: {
            withAnimation(.spring()) {
                isShowing.toggle()
            }
        }) {
            Image(systemName: "xmark")
                .frame(width: 32, height: 32)
                .foregroundColor(.purple)
                .font(.system(size: 24, weight: .bold))
        }
        .padding()
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}
