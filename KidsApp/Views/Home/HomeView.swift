//
//  HomeView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 27.09.2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthManager
    @ObservedObject var cardManager = CardManager()
    @State private var currentPage = 0
    @State var selecedCard: CreditCard
    @State var startAnimation = false
    @State var show: Bool = false
    @State var showExpences: Bool = false
    @State var showCardNumber: Bool = false
    @State var showTransferView: Bool = false
    @State var showSaveView: Bool = false
    @State var cardFlipped: Bool = false
    
    @State var cardRotation = 0.0
    @State var contentRotation = 0.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorConstants.primary)
            
            VStack {
                TopBarView(selecedCard: $selecedCard, show: $show)
                
                VStack {
                    if cardFlipped {
                        CardBackView()
                            .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
                    } else {
                        CardView(showCardNumber: $showCardNumber, card: CreditCard(number: "4141444411112222", type: CardType.Kid, company: "Visa", name: "\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")"))
                    }
                }
                .onTapGesture {
                    withAnimation(.linear(duration: 0.5)) {
                        cardRotation += 180
                    }
                    
                    withAnimation(.linear(duration: 0.001).delay(0.25)) {
                        contentRotation += 180
                        cardFlipped.toggle()
                    }
                }
                .rotation3DEffect(Angle(degrees: (cardRotation)), axis: (x: 0, y: 1, z: 0))
                
                .onLongPressGesture(minimumDuration: 0.1) {
                    withAnimation {
                        showCardNumber = true
                    }
                }
                .frame(height: 240)
                .opacity(startAnimation ? 1.0 : 0.0)
                .animation(Animation.easeIn(duration: 0.3))
                
                TransferSaveView()
                
                Group {
                    MenuHeaderView(title: "Transactions", imageName: "arrow.up.arrow.down")
                    TransactionListView(currentIndex: $currentPage, cardManager: cardManager)
                }
                .opacity(startAnimation ? 1.0 : 0.0)
                .animation(Animation.easeIn(duration: 0.5).delay(0.5))
                
                Spacer()
            }
            
            if (selecedCard.selected) {
                CardDetailView(card: $selecedCard, cardManager: cardManager)
            }
            
            
            SideMenuView(isShowing: $show)
                .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
                .offset(x: show ? 0 : -UIScreen.main.bounds.width)
                .foregroundColor(.white)
//                    .onTapGesture {
//                        self.show.toggle()
//                    }
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            show = false
            withAnimation {
                startAnimation = true
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selecedCard: creditCards[0])
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
