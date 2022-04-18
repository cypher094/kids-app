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
    @State var isLoading = false
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var city = ""
    @State var school = ""
    @State var age = ""
    @State var password = ""
    @State var phoneNumber = ""
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
            if isLoading {
                Loading()
            }
        }.navigationBarHidden(true)
    }
    
    private var inputs: some View {
        VStack(spacing: 6) {
            CustomTF(image: "person", title: "FIRST NAME", value: $firstName, animation: animation)
            CustomTF(image: "person", title: "LAST NAME", value: $lastName, animation: animation)
            CustomTF(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                .autocapitalization(.none)
            CustomTF(image: "envelope", title: "EMAIL ADDRESS", value: $email, animation: animation)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            CustomTF(image: "building.2", title: "CITY", value: $city, animation: animation)
            CustomTF(image: "graduationcap", title: "SCHOOL", value: $school, animation: animation)
            CustomTF(image: "calendar", title: "AGE", value: $age, animation: animation)
                .keyboardType(.numberPad)
            CustomTF(image: "phone", title: "PHONE NUMBER", value: $phoneNumber, animation: animation)
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
                    self.isLoading = true
                    guard !email.isEmpty, !password.isEmpty else { return }
                    auth.signUp(email: email, firstName: firstName, lastName: lastName, password: password, phoneNumber: phoneNumber, city: city, school: school, age: age)
                }) {
                    HStack(spacing: 10) {
                        Text("SIGN UP")
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
