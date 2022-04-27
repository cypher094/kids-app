//
//  MenuHeaderView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct MenuHeaderView: View {
    @Binding var reversedTapped: Bool
    let title: String
    let imageName: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 24))
                .bold()
            
            Spacer()
            
            Button(action: {
                withAnimation(.linear(duration: 0.3)) {
                    reversedTapped.toggle()
                }
            }, label: {
                Image(systemName: imageName)
            })
        }
        .foregroundColor(.white)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}
