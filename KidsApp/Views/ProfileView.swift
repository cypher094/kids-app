//
//  ProfileView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 06.04.2022.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI


class ProfileViewModel: ObservableObject {
                              
}

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
    @StateObject var profileData = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                headerView
                imageView
                profileInfo
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarHidden(true)
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
                
                Text("Profile")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Your detail information")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var profileInfo: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Full name:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("\(auth.user!.firstName) \(auth.user!.lastName)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            
                        }
                    }, label: {
                        Image(systemName: "pencil.circle")
                    })
                }
                
                HStack {
                    Text("Email address:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("\(auth.user!.email)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Phone number:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("\(auth.user!.phoneNumber)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        
        .background(Color("txtColor"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
        .padding(.top)
        .padding(.horizontal)
        
    }
    
    private var imageView: some View {
        ZStack {
            Image(auth.user?.image ?? "")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 125, height: 125)
                .clipShape(Circle())
        }
        .padding(8)
        .background(Color("txtColor"))
        .cornerRadius(90)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

