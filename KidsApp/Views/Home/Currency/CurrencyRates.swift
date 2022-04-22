//
//  CurrencyRates.swift
//  KidsApp
//
//  Created by Oleh Haidar on 22.04.2022.
//

import SwiftUI

struct CurrencyRates: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: CurrencyRatesViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding()
                
                Spacer()
                
                Text("Currencies")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Image(systemName: "dollarsign.circle.fill")
                    .font(.system(size: 35, weight: .heavy))
                    .foregroundColor(Color("purpleColor"))
                    .padding()
                
                Spacer()
            }
            
            List {
                ForEach(viewModel.currencyList, id: \.self) { currency in
                    Text("\(viewModel.amount) \(viewModel.base) = \(currency)")
                }
            }
            ForEach(viewModel.currencyList1, id: \.self) { currency in
                Text("\(viewModel.amount) \(viewModel.base) = \(currency)")
            }
        }
        .onAppear() {
            viewModel.makeRequest(showAll: false)
            viewModel.makeRequestUAH()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct CurrencyRates_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRates(viewModel: CurrencyRatesViewModel())
    }
}
