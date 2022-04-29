//
//  ProfileView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 06.04.2022.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
//    @ObservedObject var viewModel: ProfileViewModel
    @State var isPickerShowing = false
    @State var isLoading = false
    @State var selectedImage: UIImage?
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                imageView
                uploadButton
                profileInfo
                Spacer()
            }
            .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            if isLoading {
                LoadingCorrect()
            }
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
                    
                    Text("\(auth.user?.firstName ?? "") \(auth.user?.lastName ?? "")")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            
                        }
                    }, label: {
                        NavigationLink(destination: PersonalDetailView(viewModel: PersonalDetailViewModel())) {
                            Image(systemName: "pencil.circle")
                                .foregroundColor(Color.purple)
                        }
                    })
                }
                
                HStack {
                    Text("Email address:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("\(auth.user?.email ?? "")")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Phone number:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("\(auth.user?.phoneNumber ?? "")")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("City:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("\(auth.user?.city ?? "")")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("School:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("\(auth.user?.school ?? "")")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Age:")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text("\(auth.user?.age ?? "")")
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
    
    private var uploadButton: some View {
        VStack {
            if selectedImage != nil {
                Button {
                    isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        uploadPhoto()
                        isLoading = false
                    }
                } label: {
                    Text("Upload photo")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                }

            }
        }
    }
    
    private var imageView: some View {
        ZStack(alignment: .bottomTrailing) {
            Button(action: {
                isPickerShowing = true
            }, label: {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                } else {
                    Image("img2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                }
            })
        }
        .padding(8)
        .background(Color("txtColor"))
        .cornerRadius(90)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
    }
    
    func uploadPhoto() {
        guard selectedImage != nil else { return }
        let storageRef = Storage.storage().reference()
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        guard imageData != nil else { return }
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                let db = Firestore.firestore()
                db.collection("images").document().setData(["imageURL": path])
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

