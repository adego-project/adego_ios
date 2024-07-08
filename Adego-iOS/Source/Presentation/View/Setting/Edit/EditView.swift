//
//  EditView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import SwiftUI
import ComposableArchitecture

struct EditView: View {
    @Perception.Bindable var store: StoreOf<EditCore>
    
    var body: some View {
        WithPerceptionTracking {
            CustomInputTextField(
                text: "사용자 이름 (\(store.nameLength)/8)",
                input: $store.name,
                placeholder: "수정할 이름을 입력해주세요",
                isFormValid: store.isFormValid
            )
            
            if store.isFormValid {
                Text("글자가 너무 길어요.")
                    .font(.wantedSans())
                    .foregroundStyle(.red)
                    .padding(.top, 10)
            }
            
            Button {
                store.send(.dismiss)
            } label: {
                Text("저장하기")
            }
            .buttonStyle(CustomWhiteRoundedButton())
            .opacity(store.isFormValid ? 0.6 : 1)
            .disabled(store.isFormValid ? true : false)
            
            Spacer()
        }
    }
}

#Preview {
    SettingView(
        store: Store(
            initialState: SettingCore.State()
        ) {
            SettingCore()
        }
    )
}
