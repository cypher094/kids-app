//
//  SideMenuView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 22.03.2022.
//

import SwiftUI

struct SideMenuView: View {
    
    @State var isLoading = false
    @Binding var isShowing: Bool
    @EnvironmentObject var auth: AuthManager
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    SideMenuHeaderView(isShowing: $isShowing)
                        .frame(height: 150)
                    }

                ForEach(SideMenuViewModel.allCases, id: \.self) { cell in
                    NavigationLink(
                        destination:
                            VStack {
                                switch cell.title {
                                case "Profile":
                                    ProfileView()
                                case "Card Details":
                                    ChatBot()
                                case "Currency":
                                    CurrencyRates(viewModel: CurrencyRatesViewModel())
                                case "Game":
                                    MathGame()
                                case "Tutorial":
                                    TutorialView(viewModel: TutorialViewModel())
                                case "Ask a question":
                                    ChatBot()
                                default:
                                    Text(cell.title)
                                }
                            },
                        label: {
                            SideMenuCellView(viewModel: cell)
                        })
                }
                
                ZStack {
                    if isLoading {
                        LoadingSignOut()
                    } else {
                        signOut
                    }
                }
            }
            .frame(maxWidth: 300)
            .frame(height: 800)
            .padding(15)
            .background(Color("purpleMenu"))
            .cornerRadius(30)
            .shadow(color: Color("buttonShadow"), radius: 30, x: 20, y: 10)
            .shadow(color: Color("buttonShadow"), radius: 30, x: 20, y: 10)
            
            Spacer()
        }
    }
    private var signOut: some View {
        HStack {
            Button(action: {
                isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isLoading = false
                    auth.signOut()
                }
            }) {
                HStack(spacing: 10) {
                    
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title2)
                    
                    Text("SIGN OUT")
                        .fontWeight(.heavy)
                    
                }
                .modifier(CustomButtonModifier())
            }
            .padding(.top, 50)
            .padding()
        }
    }

}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
