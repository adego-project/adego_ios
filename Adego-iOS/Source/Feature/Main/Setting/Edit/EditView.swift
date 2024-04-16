//
//  EditView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: EditCore.self)
struct EditView: View {
    @Perception.Bindable var store: StoreOf<EditCore>
    var body: some View {
        CustomInputTextFieldView(
            text: "사용자 이름 (\(store.nameLength)/8)",
            input: $store.name,
            placeholder: "수정할 이름을 입력해주세요"
        )
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
