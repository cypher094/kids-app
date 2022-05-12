//
//  SideMenuViewModel.swift
//  KidsApp
//
//  Created by Oleh Haidar on 22.03.2022.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case currency
    case game
    case tutorial
    case question
    
    var title: String {
        switch self {
        case .profile: return "Profile"
        case .currency: return "Currency rates"
        case .game: return "Game"
        case .tutorial: return "Tutorial"
        case .question: return "Ask a question"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person.fill"
        case .currency: return "dollarsign.circle.fill"
        case .game: return "gamecontroller.fill"
        case .tutorial: return "questionmark.circle.fill"
        case .question: return "message.fill"
        }
    }
}
