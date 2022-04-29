//
//  PersonalDetailView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 14.03.2022.
//

import SwiftUI

struct PersonalDetailView: View {
    @EnvironmentObject var auth: AuthManager
    @ObservedObject var viewModel: PersonalDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                inputs
                signUpButton
                Spacer()
                
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            if viewModel.correctAnswerLoading {
                LoadingCorrect()
            }
        }
    }
    
    private var inputs: some View {
        VStack(spacing: 6) {
            CustomTF(image: "person", title: "FIRST NAME", value: $viewModel.firstName, animation: animation)
            CustomTF(image: "person", title: "LAST NAME", value: $viewModel.lastName, animation: animation)
            CustomTF(image: "phone", title: "PHONE NUMBER", value: $viewModel.phoneNumber, animation: animation)
                .keyboardType(.numberPad)
            CustomTF(image: "building.2", title: "CITY", value: $viewModel.city, animation: animation)
            CustomTF(image: "calendar", title: "AGE", value: $viewModel.age, animation: animation)
                .keyboardType(.numberPad)
            CustomTF(image: "graduationcap", title: "SCHOOL", value: $viewModel.school, animation: animation)
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)
                
                Text("Personal Details")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Please write your new details to update them")
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
                    viewModel.correctAnswerLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
                        auth.updateUser(firstName: viewModel.firstName, lastName: viewModel.lastName, phoneNumber: viewModel.phoneNumber, city: viewModel.city, school: viewModel.school, age: viewModel.age)
                    }
                }) {
                    HStack(spacing: 10) {
                        Text("UPDATE INFORMATION")
                            .fontWeight(.heavy)
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                    .modifier(CustomButtonModifier())
                    .opacity(!viewModel.isFieldsEmpty ? 1 : 0.6)
                }
                .disabled(viewModel.isFieldsEmpty)
            }
        }
        .padding()
        .padding(.trailing)
    }
}
