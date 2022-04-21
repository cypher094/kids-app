//
//  SignUpView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 27.09.2021.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var auth: AuthManager
    @ObservedObject var viewModel: SignUpViewModel
    @Namespace var animation
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    headerView
                    inputs
                    signUpButton
                    Spacer()
                    haveAccountButton
                }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
            if viewModel.isLoading {
                Loading()
            }
        }.navigationBarHidden(true)
    }
    
    private var inputs: some View {
        VStack(spacing: 6) {
            CustomTF(image: "person", title: "FIRST NAME", value: $viewModel.firstName, animation: animation)
            CustomTF(image: "person", title: "LAST NAME", value: $viewModel.lastName, animation: animation)
            CustomTF(image: "lock", title: "PASSWORD", value: $viewModel.password, animation: animation)
                .autocapitalization(.none)
            CustomTF(image: "envelope", title: "EMAIL ADDRESS", value: $viewModel.email, animation: animation)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            CustomTF(image: "building.2", title: "CITY", value: $viewModel.city, animation: animation)
            CustomTF(image: "graduationcap", title: "SCHOOL", value: $viewModel.school, animation: animation)
            CustomTF(image: "calendar", title: "AGE", value: $viewModel.age, animation: animation)
                .keyboardType(.numberPad)
            CustomTF(image: "phone", title: "PHONE NUMBER", value: $viewModel.phoneNumber, animation: animation)
                .keyboardType(.phonePad)
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Button(action: {
                    isPresented.toggle()
                    
                }) {
                    Image(systemName: "arrow.left")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)
                
                Text("Sign Up")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Please enter your personal details to continue")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var signUpButton: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .trailing) {
                Button(action: {
                    viewModel.isLoading = true
                    guard !viewModel.firstName.isEmpty,
                          !viewModel.lastName.isEmpty,
                          !viewModel.email.isEmpty,
                          !viewModel.password.isEmpty,
                          !viewModel.city.isEmpty,
                          !viewModel.age.isEmpty,
                          !viewModel.phoneNumber.isEmpty,
                          !viewModel.school.isEmpty
                    else { return }
                    auth.signUp(email: viewModel.email, firstName: viewModel.firstName, lastName: viewModel.lastName, password: viewModel.password, phoneNumber: viewModel.phoneNumber, city: viewModel.city, school: viewModel.school, age: viewModel.age)
                }) {
                    HStack(spacing: 10) {
                        Text("SIGN UP")
                            .fontWeight(.heavy)
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .modifier(CustomButtonModifier())
                    .opacity(viewModel.isValid ? 1 : 0.6)
                }
            }
        }
        .padding()
        .padding(.trailing)
    }
    
    private var haveAccountButton: some View {
        HStack(spacing: 8) {
            Text("Already have an account?")
                .fontWeight(.heavy)
                .foregroundColor(.gray)
            
            Button(action: {
                isPresented.toggle()
            }) {
                Text("Opps, sign In")
                    .fontWeight(.heavy)
                    .foregroundColor(Color("purpleColor"))
            }
        }
        .padding()
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(), isPresented: .constant(true))
    }
}
