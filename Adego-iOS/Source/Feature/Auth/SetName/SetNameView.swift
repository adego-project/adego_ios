//
//  SetNameView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import SwiftUI
import ComposableArchitecture

struct SetNameView: View {
    @Perception.Bindable var store: StoreOf<SetNameCore>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                WhiteTitleText(
                    title: "본인의 이름을 정해주세요"
                )

                CustomInputTextFieldView(
                    text: "사용자 이름 (\(store.nameLength)/8)",
                    input: $store.name,
                    placeholder: "사용자 이름을 입력해주세요",
                    isFormValid: store.isFormValid
                )
                .onChange(of: store.nameLength) { newValue in
                                   print("isFormValid:", store.isFormValid)
                                   print("nameLength:", store.nameLength)
                                   print("name:", store.name)
                               }
                
                if store.isFormValid {
                    Text("글자가 너무 길어요.")
                        .font(.wantedSans())
                        .foregroundStyle(.red)
                        .padding(.top, 10)
                        .animation(.easeInOut, value: store.isFormValid)
                }
                
                Spacer()
                
                Button {
                    store.send(.navigateToSetProfileImage)
                } label: {
                    Text("다음으로 넘어가기 \(Image(systemName: "arrow.right"))")
                }
                .buttonStyle(CustomWhiteRoundedButton())
                .padding(.bottom, 10)
                .disabled(store.isFormValid ? true : false)
                
            }
            .navigationBarBackButtonHidden(false)
        }
        //        .toolbar(content: {
        //            ToolbarItem(placement: .navigationBarLeading) {
        //                Button {
        //                    store.send(.navigateToSetProfileImage)
        //                } label: {
        //                    Image(systemName: "arrow.backward")
        //                        .foregroundColor(.gray50)
        //                        .font(.title3)
        //                }
        //            }
        //        })
    }
}

#Preview {
    SetNameView(
        store: Store(
            initialState: SetNameCore.State()
        ) {
        SetNameCore()
    }
    )
}
