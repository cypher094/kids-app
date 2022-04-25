//
//  SavingMoneyView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 18.04.2022.
//

import SwiftUI

struct SavingMoneyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
    @State var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                createPocketMoney
                if auth.pocketlist.isEmpty {
                    emptyList
                } else {
                    list
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showSheet) {
                AddPocketMoneyView()
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
                
                Text("Saving funds")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Here you can save money and achive your goals!")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var createPocketMoney: some View {
        HStack {
            VStack(alignment: .trailing) {
                Button(action: {
                    showSheet = true
                }) {
                    HStack(spacing: 10) {
                        Text("CREATE NEW POCKET MONEY!")
                            .fontWeight(.heavy)
                        LoadingSavings()
                    }
                    .modifier(CustomButtonModifier())
                }
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var list: some View {
        List(auth.pocketlist) { pocket in
            HStack {
                VStack(alignment: .leading) {
                    Text(pocket.name).font(.title)
                    Text("₴ \(pocket.amount)").font(.subheadline)
                }
                
                Spacer()
                
                Button {
                    auth.updatePocketMoney(updatePocket: pocket, updatedName: "123", updatedAmount: "123")
                } label: {
                    Image(systemName: "pencil.circle.fill")
                }
                .buttonStyle(BorderlessButtonStyle())
                
                Button {
                    auth.deletePocketMoney(deletePocket: pocket)
                } label: {
                    Image(systemName: "delete.left.fill")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
    
    private var emptyList: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("You have not created pocket money yet.")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding()
            .padding(.leading)
        }
    }
}

struct SavingMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        SavingMoneyView()
    }
}
