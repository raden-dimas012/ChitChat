//
//  CustomField.swift
//  ChitChat
//
//  Created by Raden Dimas on 20/04/22.
//

import SwiftUI

struct CustomField: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
    }
}
