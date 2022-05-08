//
//  SignInView.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import SwiftUI

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var model: AppStateModel
    var body: some View {
        NavigationView {
            VStack {
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120,height: 120)
                Text("ChitChat")
                    .bold()
                    .font(.system(size: 34))
                
                VStack {
                    TextField("Username", text: $username)
                        .modifier(CustomField())
                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                    
                    Button {
                        self.signIn()
                    } label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 220, height: 50)
                            .background(Color.blue)
                            .cornerRadius(6)
                    }
                    
                }
                .padding()
                Spacer()
                
                
                HStack {
                    Text("New to Messengger")
                    NavigationLink("Create an Account",destination: SignUpView())
                }
            }
        }
        
        
    }
    
    func signIn() {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
                  return
              }
        
        model.signIn(username: username, password: username)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
