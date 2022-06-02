//
//  ChitChatApp.swift
//  ChitChat
//
//  Created by Raden Dimas on 03/04/22.
//

import SwiftUI
import Firebase


@main
struct ChitChatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ConversationView()
                .environmentObject(AppStateModel())
        }
    }
}

class AppDelegate: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        debugPrint("Did Launch")
        FirebaseApp.configure()
        return true
    }
}
