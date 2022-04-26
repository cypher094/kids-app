//
//  AddNewCardView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 26.04.2022.
//

import SwiftUI

struct AddNewCardView: View {
    @EnvironmentObject var auth: AuthManager
    @State var showCardNumber = false
    @State var cardNumber = "4141444411112222"
    @State var expiredDate = ""
    @State var CVV = ""
    @Namespace var animation
    
    var body: some View {
        CustomTF(image: "building.2", title: "CVV", value: $CVV, animation: animation)
        CustomTF(image: "graduationcap", title: "EXPIRE DATE", value: $expiredDate, animation: animation)
    }
}

struct AddNewCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCardView()
    }
}
