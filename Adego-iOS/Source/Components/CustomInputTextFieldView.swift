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
    var isFormValid: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.wantedSans())
                .foregroundStyle(isFormValid ? .red : .gray60)
                .padding(.top, 40)
            
            TextField("",
                      text: input,
                      prompt: Text(placeholder)
                .placeholderStyle()
            )
            .foregroundStyle(isFormValid ? .red : .gray100)
            .frame(width: 343)
            .padding(.top, 4)
            
            Rectangle()
                .frame(width: 343, height: 1)
                .foregroundStyle(isFormValid ? .red : .gray100)
        }
    }
}
