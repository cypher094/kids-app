//
//  CharityTransferViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 02.05.2022.
//

import Foundation

class CharityTransferViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var amountToWithdraw: Double = 0.0
    
    var isFiledEmpty: Bool {
        amountToWithdraw == 0
    }
}
