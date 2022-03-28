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
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorConstants.primary)
            
            VStack {
                TopBarView(show: $show)
                
//                PagerView(pageCount: creditCards.count, currentIndex: $currentPage) {
//                    ForEach(creditCards) { card in
                        CardView(card: CreditCard(number: "4141444411112222", type: CardType.Platinum, company: "Visa", name: "\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")"))
                            .onTapGesture {
                                withAnimation {
//                                    selecedCard = card
                                    selecedCard.selected = true
                                }
                            }
//                    }
//                }
                .frame(height: 240)
//                .opacity(startAnimation ? 1.0 : 0.0)
//                .animation(Animation.easeIn(duration: 0.5))
                
                Group {
                    MenuHeaderView(title: "Transactions", imageName: "arrow.up.arrow.down")
                    TransactionListView(currentIndex: $currentPage, cardManager: cardManager)
                }
//                .opacity(startAnimation ? 1.0 : 0.0)
//                .animation(Animation.easeIn(duration: 0.5).delay(1.0))
                
                Spacer()
            }
            
            if (selecedCard.selected) {
                CardDetailView(card: $selecedCard, cardManager: cardManager)
            }
            
            SideMenuView(isShowing: $show)
                .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
//                .animation(.easeInOut(duration: 0.3))
                .offset(x: show ? 0 : -UIScreen.main.bounds.width)
                .foregroundColor(.white)
//                    .onTapGesture {
//                        self.show.toggle()
//                    }
            
//            SideMenuCustomView(currentTab: $currentTab)
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            show = false
            withAnimation {
                startAnimation.toggle()
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
