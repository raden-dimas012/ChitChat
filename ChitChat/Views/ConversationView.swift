//
//  ContentView.swift
//  ChitChat
//
//  Created by Raden Dimas on 03/04/22.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var model: AppStateModel
    @State var otherUsername: String = ""
    @State var showChat: Bool = false
    @State var showSearch: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(model.conversations, id: \.self) { name in
                    NavigationLink {
                        ChatView(otheruserName: name)
                    } label: {
                        HStack {
                            Image(model.currentUsername == "Raden" ? "Photo" : "Shane")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65, height: 65)
                                .foregroundColor(Color.pink)
                                .clipShape(Circle())
                            
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
                    NavigationLink (
                        destination: SearchView { name in
                            self.showSearch = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.otherUsername = name
                                self.showChat = true
                            }
                        },
                    isActive: $showSearch,
                    label: {
                        Image(systemName: "magnifyingglass")
                    })


                }
            }
            .fullScreenCover(isPresented: $model.showingSignIn, onDismiss: nil) {
                SignInView()
            }
            .onAppear{
                guard model.auth.currentUser != nil else {
                    return
                }
                
                model.getConverstions()
            }
           
        }
    }
    
    private func signOut() {
        model.signOut()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}
