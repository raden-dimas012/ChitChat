//
//  Message.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import Foundation

enum MessageType: String {
    case sent
    case receive
}

struct Message: Hashable{
    let text: String
    let type: MessageType
    let created: Date
    
}
