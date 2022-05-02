//
//  CharityView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 02.05.2022.
//

import SwiftUI

struct CharityView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
    @State private var shotTransfer = false
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                category1
                category2
                Spacer()
                LoadingCharityBox()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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
                
                Text("Donate money")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Select a category where to donate.")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var category1: some View {
        VStack {
            HStack {
                Text("Humanitarian aid to Ukrainians")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                NavigationLink(destination: CharityTransferView(viewModel: CharityTransferViewModel()), isActive: $shotTransfer) {
                    Button {
                        shotTransfer.toggle()
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .modifier(CustomButtonModifier())
                    }
                }
            }
            HStack {
                Text("Raising money for humanitarian aid to Ukrainians suffering from attacks by Russian military.")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
                
                Spacer()
            }
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
    
    private var category2: some View {
        VStack {
            HStack {
                Text("Help to Armed forces of Ukraine")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                NavigationLink(destination: CharityTransferView(viewModel: CharityTransferViewModel()), isActive: $shotTransfer) {
                    Button {
                        shotTransfer.toggle()
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .modifier(CustomButtonModifier())
                    }
                }
            }
            HStack {
                Text("The National Bank of Ukraine has decided to open a special acount to raise funds to support the Armed Forces.")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
                
                Spacer()
            }
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
}

struct CharityView_Previews: PreviewProvider {
    static var previews: some View {
        CharityView()
    }
}
