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
            VStack {
                CustomInputTextField(
                    text: "사용자 이름 (1/8)",
                    input: $store.name,
                    placeholder: "수정할 이름을 입력해주세요",
                    isFormValid: store.isFormValid
                )
//                
//                if store.isFormValid {
//                    Text(store.message)
//                        .font(.wantedSans())
//                        .foregroundStyle(.red)
//                        .padding(.top, 10)
//                }
                
                Spacer()
                
                Button {
                    store.send(.save(store.name))
                } label: {
                    Text("저장하기")
                }
                .buttonStyle(CustomWhiteRoundedButton())
                .opacity(store.isFormValid ? 0.6 : 1)
                .disabled(store.isFormValid ? true : false)
            }
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
