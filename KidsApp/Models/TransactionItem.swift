//
//  TransactionItem.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import Foundation

struct TransactionItem: Identifiable, Hashable {
    let id = UUID()
    let date: String
    let time: String
    let company: String
    let service: String
    let card: String
    let amount: Float
    let type: String
}
