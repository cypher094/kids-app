//
//  MenuHeaderView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct MenuHeaderView: View {
    let title: String
    let imageName: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 24))
                .bold()
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: imageName)
                    .padding(.all, 20)
            })
        }
        .foregroundColor(.white)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeaderView(title: "1", imageName: "1")
    }
}
