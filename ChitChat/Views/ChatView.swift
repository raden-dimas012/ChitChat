//
//  ChatView.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import SwiftUI

struct ChatView: View {
    @State var message: String = ""
    @EnvironmentObject var model: AppStateModel
    let otherUsername: String
    init(otheruserName: String) {
        self.otherUsername = otheruserName
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(model.messages, id: \.self) { message in
                    ChatRow(text: message.text, type: message.type)
                        .padding(3)
                }
            }
            
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                    
                
                SendButton(text: $message)
            }
            .padding()
        }
        .navigationTitle(otherUsername)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            model.otherUsername = otherUsername
            model.observeChat()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otheruserName: "Raden")
    }
}
