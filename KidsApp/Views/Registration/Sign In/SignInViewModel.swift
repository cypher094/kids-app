//
//  SignInViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 21.04.2022.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isPresented = false
    @Published var isLoading = false
    @Published var showSheet = false
    @Published var showAlert = false
    
    // MARK: - Validations
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
    
    var isFiledsEmpty: Bool {
        password.isEmpty ||
        email.isEmpty
    }
    
    var isValid: Bool {
        if !isEmailValid() {
            return false
        }
        return true
    }
}
