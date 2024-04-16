//
//  CustomInputTextFieldView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/12/24.
//

import SwiftUI

struct CustomInputTextFieldView: View {
    let text: String
    let input: Binding<String>
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .foregroundStyle(.gray60)
                .padding(.top, 40)
            
            TextField("",
                      text: input,
                      prompt: Text(placeholder)
                .placeholderStyle()
            )
            .frame(width: 343)
            .padding(.top, 4)
            .foregroundStyle(.gray100)
            
            Rectangle()
                .frame(width: 343, height: 1)
                .foregroundStyle(.gray60)
            
        }
    }
}
