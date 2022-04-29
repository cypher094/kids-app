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
                VStack(alignment: .leading, spacing: 10) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 10)
                    
                    Text("Currencies Rates")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.primary)
                    
                    Text("Below you can see the world exchange rates.")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                }
                Spacer()
            }
            .padding()
            .padding(.leading)
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.currencyList, id: \.self) { currency in
                        CurrencyRatesListRow(string: "\(viewModel.amount) \(viewModel.base) =", currency: currency)
                    }
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
