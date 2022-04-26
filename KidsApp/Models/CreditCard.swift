//
//  Card.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import Foundation

struct CreditCard: Codable {
    let number: String
    let company: String
    var selected: Bool = false
    var name: String
    var expirationDate: String
    var cvv: String
    var balance: Double
    
    func getLastFourDigit() -> String {
        return String(number.suffix(4))
    }
}
