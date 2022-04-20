//
//  SideMenuViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 22.03.2022.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case cardDetails
    case addKid
    case tutorial
    case game
    case question
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .cardDetails: return "Card Details"
        case .addKid: return "Add kid"
        case .tutorial: return "Tutorial"
        case .game: return "Game"
        case .question: return "Ask a question"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person.fill"
        case .cardDetails: return "creditcard.fill"
        case .addKid: return "plus"
        case .tutorial: return "questionmark.circle.fill"
        case .game: return "gamecontroller.fill"
        case .question: return "message.fill"
        }
    }
}
