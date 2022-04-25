//
//  ResetPasswordView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 26.04.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
    @ObservedObject var viewModel: ResetPasswordViewModel
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                xmark
                Spacer()
                headerView
                input
                resetButton
                Spacer()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Password Reset"),
                  message: Text(viewModel.errorString ?? "Success.\nYou have successfully reseted your password."),
                  dismissButton: .default(Text("OK")) {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private var xmark: some View {
        HStack {
            VStack(alignment: .leading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Reset password")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Please enter your email to reset password")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var input: some View {
        VStack(spacing: 6) {
            CustomTF(image: "envelope", title: "EMAIL", value: $viewModel.email, animation: animation)
                .autocapitalization(.none)
        }
    }
    
    private var resetButton: some View {
        HStack {

            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    auth.resetPassword(email: viewModel.email) { (result) in
                        switch result {
                        case .failure(let error):
                            viewModel.errorString = error.localizedDescription
                        case .success(_):
                            break
                        }
                        viewModel.showAlert = true
                    }
                }) {
                    HStack(spacing: 10) {
                        Text("RESET PASSWORD")
                            .fontWeight(.heavy)
                        
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .modifier(CustomButtonModifier())
                    .opacity(!viewModel.email.isEmpty ? 1 : 0.6)
                    .disabled(viewModel.email.isEmpty)
                }
            }
        }
        .padding()
        .padding(.trailing)
    }
}
