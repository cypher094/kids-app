//
//  SignUpViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 28.09.2021.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var city = ""
    @Published var school = ""
    @Published var age = ""
    @Published var password = ""
    @Published var phoneNumber = ""
    @Published var showError = false
    @Published var errorString = ""
    
    // MARK: - Validations
    
    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
    
    var isFiledsEmpty: Bool {
        firstName.isEmpty ||
        lastName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        city.isEmpty ||
        school.isEmpty ||
        age.isEmpty ||
        password.isEmpty ||
        phoneNumber.isEmpty
    }
    
    var isValid: Bool {
        if !isPasswordValid() ||
        !isEmailValid() {
            return false
        }
        return true
    }
}
