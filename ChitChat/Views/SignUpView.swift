//
//  SignUpView.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import SwiftUI

struct SignUpView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    
    @EnvironmentObject var model: AppStateModel
    var body: some View {
            VStack {
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120,height: 120)
                Text("Create Account")
                    .bold()
                    .font(.system(size: 34))
                
                VStack {
                    TextField("Email Address", text: $email)
                        .modifier(CustomField())
                    TextField("Username", text: $username)
                        .modifier(CustomField())
                    SecureField("Password", text: $password)
                        .modifier(CustomField())
                    
                    Button {
                        self.signUp()
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(Color.green)
                            .frame(width: 220, height: 50)
                            .background(Color.blue)
                            .cornerRadius(6)
                    }
                    
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Create Account")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func signUp() {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
                  return
              }
        model.signUp(email: email, username: username, password: password)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
