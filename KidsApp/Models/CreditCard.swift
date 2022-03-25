//
//  Card.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import Foundation

struct CreditCard: Identifiable {
    var id = UUID()
    let number: String
    let type: CardType
    let company: String
    var selected: Bool = false
    var name: String
    
    func getLastFourDigit() -> String {
        return String(number.suffix(4))
    }
}
