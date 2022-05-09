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
    var conversationListener: ListenerRegistration?
    var chatListener: ListenerRegistration?
    
    init() {
        self.showingSignIn = auth.currentUser == nil
    }
}


extension AppStateModel {
    func searchUsers(queryText: String,completion: @escaping ([String]) -> Void) {
        database.collection("users").getDocuments { snapshot, error in
            guard let usernames = snapshot?.documents.compactMap({ $0.documentID }),error == nil else {
                completion([])
                return
            }
            
            let filtered = usernames.filter({
                $0.lowercased().hasPrefix(queryText.lowercased())
            })
            completion(filtered)
        }
    }
}

extension AppStateModel {
    func getConverstions() {
        conversationListener = database.collection("users").document(currentUsername).collection("chats").addSnapshotListener { [weak self] snapshot, error in
            guard let username = snapshot?.documents.compactMap({ $0.documentID }), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.conversations = username
            }
        }
        
    }
}

extension AppStateModel {
    func observeChat() {
        createConversation()
        chatListener = database.collection("users").document(currentUsername).collection("chats").document(otherUsername).collection("messages")
            .addSnapshotListener { [weak self] snapshot, error in
            guard let objects = snapshot?.documents.compactMap({ $0.data() }), error == nil else {
                return
            }
                
                let messages: [Message] = objects.compactMap({
                    guard let date = ISO8601DateFormatter().date(from: $0["created"] as? String ?? "") else {
                        return nil
                    }
                    return Message(text: $0["text"] as? String ?? "", type: $0["sender"] as? String == self?.currentUsername ? .sent : .receive,
                                   created: date)
                }).sorted(by: {first,second in
                    return first.created < second.created
                })
                
            
            DispatchQueue.main.async {
                self?.messages = messages
            }
        }
    }
    
    func sendMessage(text: String) {
        
        let newMessageID = UUID().uuidString
        let dateString = ISO8601DateFormatter().string(from: Date())
        
        guard !dateString.isEmpty else {
            return
        }
         
        let data = [
            "text": text,
            "sender": currentUsername,
            "created": dateString
        ]
        database.collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername)
            .collection("messages")
            .document(newMessageID).setData(data)
        
        database.collection("users")
            .document(otherUsername)
            .collection("chats")
            .document(currentUsername)
            .collection("messages")
            .document(newMessageID).setData(data)
        
    }
    
    func createConversation() {
        
        database.collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername).setData(["created" : "true"])
        
        database.collection("users")
            .document(otherUsername)
            .collection("chats")
            .document(currentUsername).setData(["created" : "true"])
        
        
    }
}

extension AppStateModel {
    func signIn(username: String,password: String) {
        database.collection("users").document(username).getDocument { [weak self] snapshot, error in
            guard let email = snapshot?.data()?["email"] as? String, error == nil else {
                return
            }
            
            self?.auth.signIn(withEmail: email, password: password, completion: { result, error in
                guard error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.currentEmail = email
                    self?.currentUsername = username
                    self?.showingSignIn = false
                }
            })
        }
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
        do {
            try auth.signOut()
            self.showingSignIn = true
        } catch {
            print(error)
        }
        
    }
}


