//
//  Expense.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import Foundation

struct Expence: Identifiable {
    let id = UUID()
    let month: String
    let amount: Float
    var selected: Bool = false
}
