//
//  CardTransferViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 29.04.2022.
//

import Foundation

class CardTransferViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var cardNumberToWithdraw = ""
    @Published var amountToWithdraw = 0.0
    
    var isFiledsEmpty: Bool {
        cardNumberToWithdraw.isEmpty ||
        amountToWithdraw == 0
    }
}
