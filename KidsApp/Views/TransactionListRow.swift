//
//  TransactionListRow.swift
//  KidsApp
//
//  Created by Oleh Haidar on 11.03.2022.
//

import SwiftUI

struct TransactionListRow: View {
    let transaction: TransactionItem
    let isLast: Bool
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(ColorConstants.border)
                        .frame(width: 50, height: 50)
                    Image(systemName: transaction.type == "Electronics" ? "applelogo" : "gamecontroller.fill")
                        .foregroundColor(ColorConstants.secondary)
                }
                
                VStack(alignment: .leading) {
                    Text(transaction.service)
                        .foregroundColor(.white)
                    Text(transaction.type)
                        .font(.caption)
                        .foregroundColor(ColorConstants.secondary)
                }
                .padding(.leading, 10)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("- \(String(format: "%.2f", transaction.amount)) UAH")
                        .foregroundColor(.white)
                    Text(transaction.time)
                        .font(.caption)
                        .foregroundColor(ColorConstants.secondary)
                }
            }
            
            
            Divider()
                .background(ColorConstants.secondary)
                .opacity(isLast ? 0.0 : 1.0)
                .padding(.leading, 60)
                .padding(.bottom, 8)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}
