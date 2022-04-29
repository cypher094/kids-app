//
//  CurrencyRatesViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 22.04.2022.
//

import Foundation

class CurrencyRatesViewModel: ObservableObject {
    @Published var currencyList = [String]()
    @Published var currencyList1 = [String]()
    @Published var amount = "1.00"
    @Published var base = "USD"
    
    func makeRequestUAH(currencies: [String] = ["UAH"]) {
        apiRequest(url: "https://api.exchangerate.host/latest?base=\(base)&amount=\(amount)") { currency in
            var tempList = [String]()
            
            for currency in currency.rates {
                if currencies.contains(currency.key)  {
                    tempList.append("\(String(format: "%.2f",currency.value)) \(currency.key)")
                }
            }
            self.currencyList1 = tempList
        }
    }
    
    func makeRequest(showAll: Bool, currencies: [String] = ["GBP", "EUR", "PLN", "AUD", "CZK", "GEL", "TRY", "SEK", "CAD", "JPY"]) {
        apiRequest(url: "https://api.exchangerate.host/latest?base=\(base)&amount=\(amount)") { [self] currency in
            var tempList = [String]()
            
            for currency in currency.rates {
                if showAll {
                    tempList.append("\(String(format: "%.2f",currency.value)) \(currency.key)")
                } else if currencies.contains(currency.key)  {
                    tempList.append("\(String(format: "%.2f",currency.value)) \(currency.key)")
                }
                tempList.sort()
            }
            self.currencyList = tempList
        }
    }
}
