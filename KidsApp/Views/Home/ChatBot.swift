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
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding()
                
                Spacer()
                
                Text("Support")
                    .font(.largeTitle)
                    .bold()
                
                
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color("purpleColor"))
                    .padding()
                
                Spacer()
            }
            
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    // If the message contains [USER], that means it's us
                    if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                        
                        // User message styles
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
                        
                        // Bot message styles
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
            
            
            // Contains the Message bar
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
        }else if tempMessage.contains("hi") {
            return "Hey, \(auth.user?.firstName ?? "sir")!"
        }else if tempMessage.contains("bye") {
            return "Talk to you later!"
        }else if tempMessage.contains("have a problem") {
            return "Thanks for your report! Our agent will call you back soon. Stay tuned! \n"
        }else if tempMessage.contains("how are you") {
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
