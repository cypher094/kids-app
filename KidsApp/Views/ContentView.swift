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
                HomeView(selecedCard: CreditCard(number: viewModel.card?.number ?? "", company: viewModel.card?.company ?? "", selected: false, name: viewModel.card?.name ?? "", expirationDate: viewModel.card?.expirationDate ?? "", cvv: viewModel.card?.cvv ?? "", balance: viewModel.card?.balance ?? 0))
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                
            } else {
                SignInView(viewModel: SignInViewModel())
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}
