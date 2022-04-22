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
    case tutorial
    case game
    case question
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .cardDetails: return "Card Details"
        case .tutorial: return "Tutorial"
        case .game: return "Game"
        case .question: return "Ask a question"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person.fill"
        case .cardDetails: return "creditcard.fill"
        case .tutorial: return "questionmark.circle.fill"
        case .game: return "gamecontroller.fill"
        case .question: return "message.fill"
        }
    }
}
