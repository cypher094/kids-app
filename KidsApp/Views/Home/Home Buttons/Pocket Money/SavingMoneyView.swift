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
        ScrollView {
            ForEach(auth.pocketlist) { pocket in
                PocketMoneyRow(pocket: pocket, auth: auth)
            }
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
    @State var isPresentedEdit = false
    @State var isPresentedAddFunds = false
    let pocket: PocketMoney
    let auth: AuthManager
    
    var body: some View {
        VStack {
            pocketInfo
            
            VStack {
                CustomProgressView(pocket: pocket)
            }
            .padding()
            .animation(Animation.easeInOut(duration: 0.7))
            
            Divider()
                .background(ColorConstants.secondary)
                .padding(8)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
    
    var pocketInfo: some View {
        HStack(spacing: 0) {
            ZStack {
                Image(systemName: "wand.and.stars")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(ColorConstants.secondary)
            }
            
            VStack(alignment: .leading) {
                Text(pocket.name).font(.title)
                Text("\(pocket.amountFormatted) / \(pocket.goalFormatted) ₴").font(.subheadline).lineLimit(nil)
            }
            .padding(.leading, 10)
            
            Spacer()
            
            HStack(spacing: 20) {
                Button {
                    isPresentedAddFunds = true
                } label: {
                    NavigationLink(destination: AddFundsToPocketMoneyView(viewModel: AddFundsToPocketMoneyViewModel(), pocket: pocket), isActive: $isPresentedAddFunds) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                Button {
                    isPresentedEdit = true
                } label: {
                    NavigationLink(destination: SavingMoneyEditView(pocket: pocket), isActive: $isPresentedEdit) {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
            }
            .font(.system(size: 20, weight: .heavy))
            .foregroundColor(Color("purpleColor"))
            .padding(.trailing, 45)
            
            
            Button {
                auth.deletePocketMoney(deletePocket: pocket)
            } label: {
                Image(systemName: "trash.fill")
            }
            .font(.system(size: 20, weight: .heavy))
            .foregroundColor(Color.red)
            
        }
    }
}

struct CustomProgressView: View {
    let pocket: PocketMoney
    var percent: Double {
        pocket.transferedAmount / pocket.goalAmount
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Capsule()
                .fill(LinearGradient(gradient: .init(colors:
                                                        [Color("progressLeft"), Color("progressRight")]), startPoint: .leading, endPoint: .trailing))
                .frame(width: calculatePercent(), height: 20)
            
            ZStack(alignment: .trailing) {
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 20)
                Text(String(format: "%.0f", percent * 100) + "%")
                    .font(.caption)
                    .foregroundColor(Color("percentColor").opacity(0.75))
                    .padding(.trailing)
            }
        }
        .padding()
        .background(Color("txtColor"))
        .cornerRadius(16)
    }
    
    func calculatePercent() -> CGFloat {
        let width = UIScreen.main.bounds.width - 72
        return width * pocket.transferedAmount / pocket.goalAmount
    }
}

struct SavingMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        SavingMoneyView()
    }
}
