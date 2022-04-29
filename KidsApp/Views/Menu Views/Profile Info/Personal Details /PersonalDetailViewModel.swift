//
//  PersonalDetailViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 28.04.2022.
//

import Foundation

class PersonalDetailViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phoneNumber = ""
    @Published var city = ""
    @Published var school = ""
    @Published var age = ""
    
    @Published var correctAnswerLoading = false
    
    var isFieldsEmpty: Bool {
        firstName.isEmpty ||
        lastName.isEmpty ||
        phoneNumber.isEmpty ||
        city.isEmpty ||
        school.isEmpty ||
        age.isEmpty
    }
}
 
