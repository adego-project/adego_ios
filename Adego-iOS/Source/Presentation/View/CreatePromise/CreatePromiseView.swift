//
//  CreatePromiseView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/12/24.
//

import SwiftUI
import ComposableArchitecture

struct CreatePromiseView: View {
    @Perception.Bindable var store: StoreOf<CreatePromiseCore>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                WhiteTitleText(
                    title: "약속의 이름을 정해주세요"
                )
                
                CustomInputTextField(
                    text: "약속이름 (\(store.titleLength)/12)",
                    input: $store.promiseTitle,
                    placeholder: "약속 이름을 정해주세요.",
                    isFormValid: store.isFormValid
                )
                
                if store.isFormValid {
                    Text(store.message)
                        .font(.wantedSans())
                        .foregroundStyle(.red)
                        .padding(.top, 10)
                }
                
                Spacer()
                
                
                Button {
                    store.send(.navigateToSelectDayView)
                } label: {
                    Text("다음 \(Image(systemName: "arrow.right"))")
                }
                .buttonStyle(CustomWhiteRoundedButton())
                .padding(.bottom, 10)
            }
            .navigationBarHidden(false)
        }
    }
}

#Preview {
    CreatePromiseView(
        store: Store(
            initialState: CreatePromiseCore.State()
        ) {
            CreatePromiseCore()
        }
    )
}
