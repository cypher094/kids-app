//
//  User.swift
//  KidsApp
//
//  Created by Oleh Haidar on 23.03.2022.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var balance: String
    var image: String
    var signUpDate = Date.now
}
