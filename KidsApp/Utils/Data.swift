//
//  Data.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import Foundation

let creditCards = [
    CreditCard(number: "4141609013210591", company: "Visa", expirationDate: "10/24", cvv: "10/22", balance: 10),
    CreditCard(number: "4141444411113333", company: "Visa", expirationDate: "10/24", cvv: "10/22", balance: 10),
    CreditCard(number: "4141444411114444", company: "Visa", expirationDate: "10/24", cvv: "10/22", balance: 10)
]

let transactions = [
    TransactionItem(date: "8 Feb 2022", time: "14:01", company: "Supermarket", service: "Rukavycka", card: "4141609013210591", amount: 142.21, type: "Games"),
    TransactionItem(date: "2 Mar 2022", time: "09:56", company: "Valve", service: "Steam", card: "4141609013210591", amount: 400, type: "Games"),
    TransactionItem(date: "22 Mar 2022", time: "19:11", company: "Valve", service: "Steam", card: "4141609013210591", amount: 240, type: "Games"),
    TransactionItem(date: "1 Apr 2022", time: "09:22", company: "Epic Games", service: "Fortnite", card: "4141609013210591", amount: 99.99, type: "Games"),
    TransactionItem(date: "5 Apr 2022", time: "10:49", company: "Supermarket", service: "Sil'po", card: "4141609013210591", amount: 131.05, type: "Shop"),
    TransactionItem(date: "16 Apr 2022", time: "14:11", company: "Supermarket", service: "Sil'po", card: "4141609013210591", amount: 49.21, type: "Shop"),
    TransactionItem(date: "26 Apr 2022", time: "17:42", company: "Epic Games", service: "Fortnite", card: "4141609013210591", amount: 199.99, type: "Games"),
    TransactionItem(date: "9 May 2022", time: "11:02", company: "Valve", service: "Steam", card: "4141609013210591", amount: 620, type: "Games"),
    
    TransactionItem(date: "5 Mar 2022", time: "12:11", company: "Nike", service: "Nike", card: "4141444411113333", amount: 119.99, type: "Clothes"),
    TransactionItem(date: "9 Mar 2022", time: "09:10", company: "Adidas", service: "Adidas", card: "4141444411114444", amount: 120.55, type: "Shoes"),
    TransactionItem(date: "12 Mar 2022", time: "16:20", company: "Amazon", service: "Prime", card: "4141444411113333", amount: 44.99, type: "Electronics"),
    TransactionItem(date: "14 Mar 2022", time: "15:39", company: "Google", service: "Google Play", card: "4141444411114444", amount: 2.49, type: "Entertainment"),
    TransactionItem(date: "14 Mar 2022", time: "19:41", company: "Apple", service: "Airpods Pro", card: "4141444411113333", amount: 340, type: "Electronics")

]

let expences = [
    Expence(month: "Jan", amount: 0.00),
    Expence(month: "Feb", amount: 142.21),
    Expence(month: "Mar", amount: 640.00),
    Expence(month: "Apr", amount: 480.24),
    Expence(month: "May", amount: 620.00),
    Expence(month: "Jun", amount: 0.00),
]
