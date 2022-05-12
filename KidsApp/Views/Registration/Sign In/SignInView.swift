//
//  SignInView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 27.09.2021.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var auth: AuthManager
    @ObservedObject var viewModel: SignInViewModel
    @State var authError: EmailAuthError?
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                headerView
                inputs
                signInResetButtons
                Spacer()
                createAccountButton
            }
            .sheet(isPresented: $viewModel.showSheet) {
                ResetPasswordView(viewModel: ResetPasswordViewModel())
            }
            if viewModel.isLoading {
                Loading()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Login error."),
                  message: Text(authError?.localizedDescription ?? "Unknown error"),
                  dismissButton: .default(Text("OK")) {
                withAnimation(.linear(duration: 0.1)) {
                    if authError == .incorrectPassword {
                        viewModel.password = ""
                    } else {
                        viewModel.password = ""
                        viewModel.email = ""
                    }
                }
            })
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
            CustomTF(image: "envelope", title: "EMAIL", value: $viewModel.email, animation: animation)
                .autocapitalization(.none)
            CustomTF(image: "lock", title: "PASSWORD", value: $viewModel.password, animation: animation)
                .autocapitalization(.none)
        }
    }
    
    private var signInResetButtons: some View {
        HStack {
            
            VStack {
                Button(action: {
                    viewModel.showSheet = true
                }) {
                    Text("Forgot password?")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .padding(.leading)

            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    viewModel.isLoading = true
                    guard !viewModel.email.isEmpty,
                          !viewModel.password.isEmpty else { return }
                    auth.signIn(email: viewModel.email,
                                password: viewModel.password, completion: { (result) in
                        switch result {
                        case .failure(let error):
                            self.authError = error
                            viewModel.showAlert = true
                        case .success(_):
                            print("Signed in")
                        }
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        viewModel.isLoading = false
                    }
                }) {
                    HStack(spacing: 10) {
                        Text("SIGN IN")
                            .fontWeight(.heavy)
                        
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .modifier(CustomButtonModifier())
                    .opacity(viewModel.isValid && !viewModel.isFiledsEmpty ? 1 : 0.6)
                }
                .disabled(!viewModel.isValid && viewModel.isFiledsEmpty)
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
            
            NavigationLink(destination: SignUpView(viewModel: SignUpViewModel(), isPresented: $viewModel.isPresented), isActive: $viewModel.isPresented) {
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
        SignInView(viewModel: SignInViewModel())
    }
}
