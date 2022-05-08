//
//  AppStateModel.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import Foundation
import SwiftUI

class AppStateModel: ObservableObject {
    @Published var showingSignIn: Bool = true
    @AppStorage("currentUsername") var currentUsername: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""
    
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []
    var otherUsername = ""

}


extension AppStateModel {
    func searchUsers(queryText: String,completion: @escaping ([String]) -> Void) {
        
    }
}

extension AppStateModel {
    func getConverstions() {
        
    }
}

extension AppStateModel {
    func observeChat() {
        
    }
    
    func sendMessage(text: String) {
        
    }
    
    func createConversationIfNeeded() {
        
    }
}

extension AppStateModel {
    func signIn(username: String,password: String) {
        
    }
    
    
    func signUp(email: String,username: String,password: String) {
        
    }
    
    func signOut() {
        
    }
}


