//
//  CustomButton.swift
//  KidsApp
//
//  Created by Oleh Haidar on 28.09.2021.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.white)
            .padding(.vertical)
            .padding(.horizontal, 35)
            .background(
                LinearGradient(gradient: .init(colors: [Color("navy"), Color.purple]), startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(Capsule())
    }
}

