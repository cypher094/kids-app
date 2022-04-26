//
//  ResetPasswordViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 26.04.2022.
//

import Foundation

class ResetPasswordViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var email = ""
    @Published var errorString: String?
}
