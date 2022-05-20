//
//  CardDetailView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct CardDetailView: View {
    
    @Binding var card: CreditCard
    @ObservedObject var cardManager: CardManager
    @State var startAnimation = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorConstants.primary)
                
            VStack {
                CardDetailTopBarView(card: $card)
                
                ZStack {
                    GeometryReader { geometry in
                        CardView()
                            .rotationEffect(startAnimation ? Angle.degrees(90) : Angle.degrees(0))
                            .offset(x: startAnimation ? -geometry.size.width/2 : 0)
                    }
                    .frame(height: 240)

                    CardInfoView()
                        .padding(.leading, 80)
                        .opacity(startAnimation ? 1.0 : 0.0)
                        .animation(Animation.easeIn(duration: 0.4).delay(0.4))
                    
                }
                .padding(.top, 50)
                .padding(.bottom, 60)
                
                ExpenceView(cardManager: cardManager)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                    .opacity(startAnimation ? 1.0 : 0.0)
                    .animation(Animation.easeIn(duration: 0.5).delay(0.5))
                
                Spacer()
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 0.6)) {
                startAnimation = true
            }
        }
    }
}

struct ExpenceView: View {
    @ObservedObject var cardManager: CardManager
    @State var reverseTransaction = false
    var body: some View {
        VStack {
            MenuHeaderView(reversedTapped: $reverseTransaction, title: "Expences", imageName: "ellipsis")
                .padding(.bottom, 20)
            GraphView(cardManager: cardManager)
        }
    }
}

struct CardDetailTopBarView: View {
    @Binding var card: CreditCard
    var body: some View {
        HStack {
            Button(action: {
                card.selected = false
            }, label: {
                Image(systemName: "multiply")
            })
            
            Spacer()
            
            Text("CARD DETAILS")
                .kerning(2.0)
                .bold()
                .padding(.trailing, 10)
            
            Spacer()
            
        }
        .foregroundColor(.white)
        .padding(.top, 64)
        .padding(.bottom, 25)
        .padding(.leading, 25)
        .padding(.trailing, 25)
    }
}

