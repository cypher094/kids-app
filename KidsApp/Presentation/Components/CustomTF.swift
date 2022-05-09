//
//  CustomTF.swift
//  KidsApp
//
//  Created by Oleh Haidar on 28.09.2021.
//

import SwiftUI

struct CustomTF: View {
    
    var image: String
    var title: String
    @Binding var value: String
    
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(alignment: .bottom) {
                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundColor(value == "" ? .gray : .primary)
                    .frame(width: 35)
                
                VStack(alignment: .leading, spacing: 6) {
                    if value != "" {
                        Text(title)
                            .font(.caption)
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: title, in: animation)
                    }
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        if value == "" {
                            Text(title)
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: title, in: animation)
                        }
                        if title == "PASSWORD" {
                            SecureField("", text: $value)
                        } else {
                            TextField("", text: $value)
                                .disableAutocorrection(true)
                                .submitLabel(.return)
                        }
                    }
                }
            }
            if value == "" {
                Divider()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        
        .background(Color("txtColor").opacity(value != "" ? 1 : 0))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(value == "" ? 0 : 0.05), radius: 5, x: -5, y: -5)
        .shadow(color: Color.black.opacity(value == "" ? 0 : 0.1), radius: 5, x: 5, y: 5)
        .padding(.top)
        .padding(.horizontal)
        .animation(.linear)
    }
}

struct AmountTF: View {
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var image: String
    var title: String
    @Binding var value: Double
    
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(alignment: .bottom) {
                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundColor(value == nil ? .gray : .primary)
                    .frame(width: 35)
                
                VStack(alignment: .leading, spacing: 6) {
                    if value != nil {
                        Text(title)
                            .font(.caption)
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: title, in: animation)
                    }
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        if value == nil {
                            Text(title)
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: title, in: animation)
                        }
                        TextField("", value: $value, formatter: formatter)
                            .disableAutocorrection(true)
                            .submitLabel(.return)
                    }
                }
            }
            if value == nil {
                Divider()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        
        .background(Color("txtColor").opacity(value != nil ? 1 : 0))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(value == nil ? 0 : 0.05), radius: 5, x: -5, y: -5)
        .shadow(color: Color.black.opacity(value == nil ? 0 : 0.1), radius: 5, x: 5, y: 5)
        .padding(.top)
        .padding(.horizontal)
        .animation(.linear)
    }
}
