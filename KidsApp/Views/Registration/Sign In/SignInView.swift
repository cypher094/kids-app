//
//  SignInView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 27.09.2021.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var auth: AuthManager
    
    @State var email = ""
    @State var password = ""
    @State var isPresented = false
    @State var isLoading = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                headerView
                inputs
                signInButton
                Spacer()
                createAccountButton
            }
            if isLoading {
                Loading()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Sign In")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Please sign in to continue")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var inputs: some View {
        VStack(spacing: 6) {
            CustomTF(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                .autocapitalization(.none)
            CustomTF(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                .autocapitalization(.none)
        }
    }
    
    private var signInButton: some View {
        HStack {
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    isLoading = true
                    guard !email.isEmpty, !password.isEmpty else { return }
                    auth.signIn(email: email, password: password)
                }) {
                    HStack(spacing: 10) {
                        Text("SIGN IN")
                            .fontWeight(.heavy)
                        
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .modifier(CustomButtonModifier())
                }
            }
        }
        .padding()
        .padding(.trailing)
    }
    
    private var createAccountButton: some View {
        HStack(spacing: 8) {
            Text("Do not have an account?")
                .fontWeight(.heavy)
                .foregroundColor(.gray)
            
            NavigationLink(destination: SignUpView(viewModel: SignUpViewModel(), isPresented: $isPresented), isActive: $isPresented) {
                Text("Sign Up")
                    .fontWeight(.heavy)
                    .foregroundColor(Color("purpleColor"))
            }
        }
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
