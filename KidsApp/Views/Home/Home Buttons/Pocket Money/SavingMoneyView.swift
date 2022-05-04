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
                    LoadingPig()
                } else {
                    list
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showSheet) {
                AddPocketMoneyView(viewModel: AddPocketMoneyViewModel())
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
                
                Text("Save your funds")
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
        ForEach(auth.pocketlist) { pocket in
            PocketMoneyRow(pocket: pocket, auth: auth)
        }
    }
    
    private var emptyList: some View {
        HStack {
            VStack {
                Text("You have not created pocket money yet.\nIt is to start save your money.")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
}

struct PocketMoneyRow: View {
    @State var isPresented = false
    let pocket: PocketMoney
    let auth: AuthManager
    
    var body: some View {
            VStack {
                HStack(spacing: 0) {
                    ZStack {
                        Image(systemName: "wand.and.stars")
                            .font(.system(size: 30, weight: .heavy))
//                            .foregroundColor(Color("purpleColor"))
                            .foregroundColor(ColorConstants.secondary)
                    }
                    
                    VStack {
                        Text(pocket.name).font(.title)
                        Text("\(pocket.amount)₴").font(.subheadline)
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button {
//                            auth.updatePocketMoney(updatePocket: pocket, updatedName: "123", updatedAmount: "123")
                            isPresented = true
                        } label: {
                            NavigationLink(destination: SavingMoneyEditView(pocket: pocket), isActive: $isPresented) {
                                Image(systemName: "pencil.circle.fill")
                            }
                        }
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(Color("purpleColor"))
                        
                        Button {
                            auth.deletePocketMoney(deletePocket: pocket)
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(Color("purpleColor"))
                    }

                }
                
                Divider()
                    .background(ColorConstants.secondary)
                    .padding(.leading, 60)
                    .padding(.bottom, 8)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        
    }
}


struct SavingMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        SavingMoneyView()
    }
}
