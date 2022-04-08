//
//  ContentView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 27.09.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthManager
    
    var body: some View {
        NavigationView {
            if viewModel.userIsAuthenticatedAndSynced {
                HomeView(selecedCard: CreditCard(number: "4141444411112222", type: CardType.KidBasic, company: "Visa", name: "\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")"))
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                
            } else {
                SignInView()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}
