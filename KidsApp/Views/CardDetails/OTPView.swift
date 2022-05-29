//
//  OTPView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 02.05.2022.
//

import SwiftUI

struct OTPView: View {
    var body: some View {
        ZStack {
            VStack {
                Verification()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .animation(.spring())
    }
}

struct Verification: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var code: [String] = []
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                dots
                Spacer()
                NumberPad(codes: $code, loading: $isLoading)
                    .padding(.bottom, 20)
            }
            if isLoading {
                LoadingCorrect()
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
                
                Text("Change PIN")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.primary)
                
                Text("Enter new pin code to continue.")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
        .padding()
        .padding(.leading)
    }
    
    private var dots: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(code, id: \.self) { _ in
                Text("*")
                    .font(.system(size: 15, weight: .heavy))
                    .foregroundColor(Color.white)
                    .modifier(CustomButtonModifier())
                    .clipShape(Circle())
            }
        }
        .padding(.vertical)
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}

struct NumberPad: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var auth: AuthManager
    @Binding var codes: [String]
    @Binding var loading: Bool
    
    var body: some View {
        VStack(alignment: . leading, spacing: 20) {
            ForEach(datas) { i in
                HStack(spacing: getSpacing()) {
                    ForEach(i.row) { j in
                        Button {
                            if j.value == "delete.left.fill" {
                                codes.removeLast()
                            } else {
                                codes.append(j.value)
                                
                                if codes.count == 4 {
                                    print(getPin())
                                    
                                    NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
                                    
                                    loading = true

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        codes.removeAll()
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                            let pin = codes.joined(separator: "")
                            auth.updatePin(pin: pin)
                        } label: {
                            if j.value == "delete.left.fill" {
                                Image(systemName: j.value)
                                    .font(.system(size: 30, weight: .bold))
                            } else {
                                Text(j.value)
                                    .font(.system(size: 30, weight: .bold))
                                    .padding(.vertical)
                            }
                        }
                        .disabled(codes.count == 4)
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.white)
                        .modifier(CustomButtonModifier())
                        .clipShape(Circle())
                    }
                }
            }
        }
    }
    
    func getSpacing() -> CGFloat {
        return UIScreen.main.bounds.width / 35
    }
    
    func getPin() -> String {
        var code = ""

        for i in codes {
            code += i
        }
        
        return code
    }
}

// Datas

struct type: Identifiable {
    var id: Int
    var row: [row]
}

struct row: Identifiable {
    var id: Int
    var value: String
}

var datas = [
    type(id: 0, row: [row(id: 0, value: "1"), row(id: 1, value: "2"), row(id: 2, value: "3")]),
    type(id: 1, row: [row(id: 0, value: "4"), row(id: 1, value: "5"), row(id: 2, value: "6")]),
    type(id: 2, row: [row(id: 0, value: "7"), row(id: 1, value: "8"), row(id: 2, value: "9")]),
    type(id: 3, row: [row(id: 0, value: "delete.left.fill"), row(id: 1, value: "0")]),
]
