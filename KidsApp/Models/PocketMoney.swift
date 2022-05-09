//
//  PocketMoney.swift
//  KidsApp
//
//  Created by Oleh Haidar on 25.04.2022.
//

import Foundation

struct PocketMoney: Identifiable, Codable {
    var id: String
    var name: String
    var goalAmount: Double
    var transferedAmount: Double
    
    var goalFormatted: String {
        return String(format: "%.2f", self.goalAmount)
    }
    
    var amountFormatted: String {
        return String(format: "%.2f", self.transferedAmount)
    }
    
//    init(id: String = "",
//         name: String,
//         goalAmount: Double,
//         transferedAmount: Double) {
//        self.id = id
//        self.name = name
//        self.goalAmount = goalAmount
//        self.transferedAmount = transferedAmount
//    }
}
