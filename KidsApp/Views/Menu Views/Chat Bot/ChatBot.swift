//
//  ChatBot.swift
//  KidsApp
//
//  Created by Oleh Haidar on 19.04.2022.
//

import SwiftUI

struct ChatBot: View {
    @EnvironmentObject var auth: AuthManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to our chat!\nSend your question."]
    
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
                    
                    Text("Support")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.primary)
                    
                    Text("Enter your problem to get a quick answer.")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                }
                Spacer()
            }
            .padding()
            .padding(.leading)
            
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                        HStack {
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(
                                    LinearGradient(gradient: .init(colors: [Color("navy"), Color.purple]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)

                        }
                    } else {
                        HStack {
                            Text(message)
                                .padding()
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                    
                }.rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            .background(Color.gray.opacity(0.1))
            
            HStack {
                TextField("Type something", text: $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }
                
                Button {
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(Color("purpleColor"))
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[USER]" + message)
            self.messageText = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    messages.append(getBotResponse(message: message))
                }
            }
        }
    }
    
    func getBotResponse(message: String) -> String {
        let tempMessage = message.lowercased()
        
        if tempMessage.contains("hello") {
            return "Hey there! What's your problem?"
        } else if tempMessage.contains("hi") {
            return "Hey, \(auth.user?.firstName ?? "sir")!"
        } else if tempMessage.contains("bye") {
            return "Talk to you later!"
        } else if tempMessage.contains("have a problem") {
            return "Thanks for your report! Our agent will call you back soon. Stay tuned! \n"
        } else if tempMessage.contains("doesn't work") {
            return "Thanks for your report! Our agent will call you back soon. Stay tuned! \n"
        } else if tempMessage.contains("how are you") {
            return "I'm fine, how about you?"
        } else {
            return "That's cool."
        }
    }
}

struct ChatBot_Previews: PreviewProvider {
    static var previews: some View {
        ChatBot()
    }
}
