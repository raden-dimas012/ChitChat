//
//  AppStateModel.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AppStateModel: ObservableObject {
    @Published var showingSignIn: Bool = true
    @AppStorage("currentUsername") var currentUsername: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""
    
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []
    var otherUsername = ""
    
    let database = Firestore.firestore()
    let auth = Auth.auth()
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
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
               return
            }
            
            let data = [
                "email": email,
                "username": username
            ]
            
            self?.database.collection("users").document(username).setData(data) { error in
                guard error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.currentUsername = username
                    self?.currentEmail = email
                    self?.showingSignIn = false
                }
               
            }
        }
    }
    
    func signOut() {
        
    }
}


