//
//  CustomHomeButton.swift
//  KidsApp
//
//  Created by Oleh Haidar on 15.04.2022.
//

import SwiftUI

struct CustomHomeButton: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.white)
            .padding(.vertical)
            .padding(.horizontal, 25)
            .background(
                LinearGradient(gradient: .init(colors: [Color("navy"), Color.purple]), startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(Capsule())
    }
}
