//
//  ChatRow.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import SwiftUI

struct ChatRow: View {
    let type: MessageType
    let text: String
    var isSender: Bool {
        return type == .sent
    }
    
    init(text: String,type: MessageType) {
        self.type = type
        self.text = text
    }
    
    var body: some View {
        HStack {
            if isSender {
                Spacer()
            }
            
            if !isSender {
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color.pink)
                    
                }
            }
            HStack {
                Text(text)
                    .foregroundColor(isSender ? Color.white : Color(.label))
                    .padding()
            }
            .background(isSender ? Color.blue : Color(.systemGray4))
            .padding(isSender ? .leading : .trailing, isSender ? UIScreen().bounds.width/3 : UIScreen().bounds.width/5)
            .cornerRadius(8)
            
            if !isSender {
                Spacer()
            }
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChatRow(text: "hello world", type: .sent)
            ChatRow(text: "hello world", type: .receive)
        }
    }
}
