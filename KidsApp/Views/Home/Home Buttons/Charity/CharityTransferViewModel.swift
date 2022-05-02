//
//  CharityTransferViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 02.05.2022.
//

import Foundation

class CharityTransferViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var amountToWithdraw = ""
    
    var isFiledEmpty: Bool {
        amountToWithdraw.isEmpty
    }
}
