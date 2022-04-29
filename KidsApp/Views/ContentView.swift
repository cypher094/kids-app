//
//  ContentView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 27.09.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    
    var body: some View {
        NavigationView {
            if authManager.userIsAuthenticatedAndSynced {
                HomeView(selecedCard: CreditCard(number: authManager.card?.number ?? "", company: authManager.card?.company ?? "", selected: false, expirationDate: authManager.card?.expirationDate ?? "", cvv: authManager.card?.cvv ?? "", balance: authManager.card?.balance ?? 0))
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                
            } else {
                SignInView(viewModel: SignInViewModel())
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                launchScreenManager.dismiss()
            }
        }
    }
}
