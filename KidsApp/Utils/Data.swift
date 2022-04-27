//
//  Data.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import Foundation

let creditCards = [
    CreditCard(number: "4141444411112222", company: "Visa", expirationDate: "10/24", cvv: "10/22", balance: 10),
    CreditCard(number: "4141444411113333", company: "Visa", expirationDate: "10/24", cvv: "10/22", balance: 10),
    CreditCard(number: "4141444411114444", company: "Visa", expirationDate: "10/24", cvv: "10/22", balance: 10)
]

let transactions = [
    TransactionItem(date: "1 Apr 2022", time: "09:22", company: "Epic Games", service: "Fortnite", card: "4141444411112222", amount: 99.99, type: "Games"),
    TransactionItem(date: "2 Mar 2022", time: "09:56", company: "Valve", service: "Steam", card: "4141444411112222", amount: 400, type: "Games"),
    TransactionItem(date: "5 Mar 2022", time: "12:11", company: "Nike", service: "Nike", card: "4141444411113333", amount: 119.99, type: "Clothes"),
    TransactionItem(date: "9 Mar 2022", time: "09:10", company: "Adidas", service: "Adidas", card: "4141444411114444", amount: 120.55, type: "Shoes"),
    TransactionItem(date: "12 Mar 2022", time: "16:20", company: "Amazon", service: "Prime", card: "4141444411113333", amount: 44.99, type: "Electronics"),
    TransactionItem(date: "14 Mar 2022", time: "15:39", company: "Google", service: "Google Play", card: "4141444411114444", amount: 2.49, type: "Entertainment"),
    TransactionItem(date: "14 Mar 2022", time: "19:41", company: "Apple", service: "AirPods", card: "4141444411112222", amount: 2200, type: "Electronics"),
    TransactionItem(date: "14 Mar 2022", time: "19:41", company: "Apple", service: "Airpods Pro", card: "4141444411113333", amount: 340, type: "Electronics")

]

let expences = [
    Expence(month: "Mar", amount: 1075.00),
    Expence(month: "Apr", amount: 340.00),
    Expence(month: "May", amount: 600.00),
    Expence(month: "Jun", amount: 320.90),
]
