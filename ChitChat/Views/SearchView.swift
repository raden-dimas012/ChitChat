//
//  SearchView.swift
//  ChitChat
//
//  Created by Raden Dimas on 18/04/22.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var text: String = ""
    let username: [String] = ["Julia"]
    let completion: ((String)) -> Void
    
    init(completion: @escaping((String)) -> Void ) {
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            TextField("Username...", text: $text)
                .modifier(CustomField())
            
            Button("Search") {
                
            }
            
            List {
                ForEach(username, id: \.self) { name in
                    HStack {
                        Circle()
                            .frame(width: 55, height: 55)
                            .foregroundColor(Color.green)
                        
                        Text(name)
                            .font(.system(size: 24))
                        Spacer()
                    }
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                        completion(name)
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView() { _ in}
            .preferredColorScheme(.dark)
    }
}
