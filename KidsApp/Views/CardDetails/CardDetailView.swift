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
                        CardView(card: card)
                            .rotationEffect(startAnimation ? Angle.degrees(90) : Angle.degrees(0))
                            .offset(x: startAnimation ? -geometry.size.width/2 : 0)
                    }
                    .frame(height: 200)

                    CardInfoView()
                        .padding(.leading, 80)
                        .opacity(startAnimation ? 1.0 : 0.0)
                        .animation(Animation.easeIn(duration: 0.5).delay(1.0))
                    
                }
                .padding(.top, 40)
                .padding(.bottom, 50)
                
                ExpenceView(cardManager: cardManager)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                    .opacity(startAnimation ? 1.0 : 0.0)
                    .animation(Animation.easeIn(duration: 0.5).delay(1.5))
                
                Spacer()
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 1.0)) {
                startAnimation = true
            }
            
        }
    }
}

struct ExpenceView: View {
    @ObservedObject var cardManager: CardManager
    var body: some View {
        VStack {
            MenuHeaderView(title: "Expences", imageName: "ellipsis")
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
                withAnimation {
                    card.selected = false
                }
            }, label: {
                Image(systemName: "multiply")
                    .padding(.all, 20)
            })
            
            Text("CARD DETAILS")
                .kerning(2.0)
                .bold()
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "slider.vertical.3")
                    .padding(.all, 20)
            })
        }
        .foregroundColor(.white)
        .padding(.top, 64)
        .padding(.bottom, 20)
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

