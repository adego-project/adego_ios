//
//  CustomInputTextFieldView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/12/24.
//

import SwiftUI

struct CustomInputTextField: View {
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
            
            ZStack(alignment: .leading) {
                Text(input.wrappedValue.isEmpty ? placeholder : input.wrappedValue)
                    .foregroundColor(isFormValid ? .red : .gray)
                    .opacity(input.wrappedValue.isEmpty ? 0.5 : 1.0)
                
                TextField("",
                          text: input
                )
                .foregroundColor(.clear)
                .frame(width: 343)
                .opacity(1)
            }
            
            Rectangle()
                .foregroundStyle(isFormValid ? .red : .gray100)
                .frame(width: 343, height: 1)
        }
    }
}
