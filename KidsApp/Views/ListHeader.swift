//
//  ListHeader.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct ListHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(ColorConstants.secondary)
                .padding(.leading, 20)
            Spacer()
        }
    }
}
