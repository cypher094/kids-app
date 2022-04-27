//
//  PersonalDetailView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 14.03.2022.
//

import SwiftUI

//class PersonalDetailViewModel: ObservableObject {
//
//}

struct PersonalDetailView: View {
    @EnvironmentObject var auth: AuthManager
//    @ObservedObject var viewModel: PersonalDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @State var phoneNumber = ""
    @Namespace var animation
    
    
    var body: some View {
        NavigationView {
            VStack {
                headerView
                inputs
                signUpButton
                Spacer()
                
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }.navigationBarHidden(true)
    }
    
    private var inputs: some View {
        VStack(spacing: 6) {
            CustomTF(image: "person", title: "FIRST NAME", value: $firstName, animation: animation)
            CustomTF(image: "person", title: "LAST NAME", value: $lastName, animation: animation)
            CustomTF(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                .autocapitalization(.none)
            CustomTF(image: "phone", title: "PHONE NUMBER", value: $phoneNumber, animation: animation)
                .keyboardType(.numberPad)
            CustomTF(image: "envelope", title: "EMAIL ADDRESS", value: $email, animation: animation)
                .autocapitalization(.none)
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
//                    guard !email.isEmpty, !password.isEmpty else { return }
                    auth.updateUser(firstName: firstName, lastName: lastName)
                }) {
                    HStack(spacing: 10) {
//                        NavigationLink(destination: TutorialView(viewModel: TutorialViewModel()), isActive: $viewModel.isNextScreenPresenting) {
                            Text("UPDATE INFORMATION")
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


struct PersonalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailView()
    }
}
