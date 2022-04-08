//
//  AddKidView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 05.04.2022.
//

import SwiftUI

struct AddKidView: View {
    @EnvironmentObject var auth: AuthManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLoading = false
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @State var phoneNumber = ""
    @Namespace var animation
    
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    headerView
                    inputs
                    signUpButton
                    Spacer()
                }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                if isLoading {
                    Loading()
                }
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
            CustomTF(image: "phone", title: "PHONE NUMBER", value: $phoneNumber, animation: animation)
                .keyboardType(.phonePad)
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "arrow.left")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)
                
                Text("Add kid")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Please enter personal details of your kid to continue")
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
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 10) {
//                        NavigationLink(destination: TutorialView(viewModel: TutorialViewModel()), isActive: $viewModel.isNextScreenPresenting) {
                            Text("ADD KID")
                                .fontWeight(.heavy)
//                        }
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
}


