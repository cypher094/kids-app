//
//  AddPocketMoneyViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 29.04.2022.
//

import Foundation

class AddPocketMoneyViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var goalText = ""
    @Published var amount: Double = 0
    
    var isFiledsEmpty: Bool {
        goalText.isEmpty ||
        amount == 0
    }
}
