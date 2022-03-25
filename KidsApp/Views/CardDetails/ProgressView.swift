//
//  ProgressView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct ProgressView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4.0)
                .fill(ColorConstants.border)
                .frame(width: 50, height: 50)
            
            Circle()
                .trim(from: 0.0, to: 3/5)
                .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round))
                .fill(ColorConstants.graphLine)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle.degrees(-90))
            
            Text("3/5")
                .font(.system(size: 14.0))
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
