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
            if viewModel.signedIn {
                HomeView(selecedCard: creditCards[0])
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                
            } else {
                SignInView()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}
