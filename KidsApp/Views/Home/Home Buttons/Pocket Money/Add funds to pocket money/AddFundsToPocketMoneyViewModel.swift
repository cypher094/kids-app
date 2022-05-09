//
//  AddFundsToPocketMoneyViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 06.05.2022.
//

import Foundation

class AddFundsToPocketMoneyViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var amountToWithdraw = 0.00
    
    var isFiledEmpty: Bool {
        amountToWithdraw <= 0
    }
}
