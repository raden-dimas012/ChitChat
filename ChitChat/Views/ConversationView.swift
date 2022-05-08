//
//  ContentView.swift
//  ChitChat
//
//  Created by Raden Dimas on 03/04/22.
//

import SwiftUI

struct ConversationView: View {
    
    let usernames: [String] = ["Raden","Dimas","Akbar"]
    @EnvironmentObject var model: AppStateModel
    @State var otherUsername: String = ""
    @State var showChat: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(usernames, id: \.self) { name in
                    NavigationLink {
                        ChatView(otheruserName: name)
                    } label: {
                        HStack {
                            Circle()
                                .frame(width: 65, height: 65)
                                .foregroundColor(Color.pink)
                            
                            Text(name)
                                .bold()
                                .foregroundColor(Color(.label))
                                .font(.system(size: 32))
                            Spacer()
                        }
                        .padding()
                    }

                }
                if !otherUsername.isEmpty {
                    NavigationLink("", isActive: $showChat) {
                        ChatView(otheruserName: otherUsername)
                    }
                }
            }
            .navigationTitle("Conversations")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button("Sign Out") {
                        self.signOut()
                    }

                }

                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink {
                        SearchView { name in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.otherUsername = name
                                self.showChat = true
                            }
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }


                }
            }
            .fullScreenCover(isPresented: $model.showingSignIn, onDismiss: nil) {
                SignInView()
            }
           
        }
    }
    
    private func signOut() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}
