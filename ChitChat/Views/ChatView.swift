//
//  ChatView.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import SwiftUI

struct ChatView: View {
    @State var message: String = ""
    let otherUsername: String
    init(otheruserName: String) {
        self.otherUsername = otheruserName
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ChatRow(text: "Hello world", type: .sent)
                    .padding(3)
                ChatRow(text: "Hello World", type: .receive)
                    .padding(3)
            }
            
            HStack {
                TextField("Message...", text: $message)
                    .modifier(CustomField())
                    
                
                SendButton(text: $message)
            }
            .padding()
        }
        .navigationTitle(otherUsername)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otheruserName: "Raden")
    }
}
