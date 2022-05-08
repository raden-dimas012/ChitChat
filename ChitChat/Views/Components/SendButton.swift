//
//  SendButton.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import SwiftUI

struct SendButton: View {
    
    @Binding var text: String
    
    var body: some View {
        Button {
            self.sendMessage()
        } label: {
            Image(systemName: "paperplane")
                .font(.system(size: 32))
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .clipShape(Circle())
        }
    }
    
    private func sendMessage() {
        guard !text.isEmpty else {
            return
        }
        
    }
}

//struct SendButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SendButton()
//    }
//}
