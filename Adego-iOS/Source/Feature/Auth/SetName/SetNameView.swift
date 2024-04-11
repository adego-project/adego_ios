//
//  SetNameView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: SetNameCore.self)
struct SetNameView: View {
    @Perception.Bindable var store: StoreOf<SetNameCore>
    
    public init(store: StoreOf<SetNameCore>) {
      self.store = store
    }
    

    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                Text("본인의 이름을 정해주세요")
                    .font(.wantedSans(24, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.top, 76)
                Text("사용자 이름 (\(store.stringLength)/8)")
                    .foregroundStyle(.gray60)
                    .padding(.top, 40)
                
                TextField("", 
                          text: $store.name,
                          prompt: Text("전화번호를 입력해주세요")
                            .placeholderStyle()
                )
                    .frame(width: 343)
                    .padding(.top, 4)
                    .foregroundStyle(.gray100)
                
                Rectangle()
                    .frame(width: 343, height: 1)
                    .foregroundStyle(.gray60)
                
                Spacer()
                
                Button {
                    store.send(.navigateToSetProfileImage)
                } label: {
                    Text("다음으로 넘어가기 \(Image(systemName: "arrow.right"))")
                        .font(.wantedSans(weight: .midium))
                        .foregroundStyle(.gray10)
                        .frame(width: 343, height: 56)
                        .background(.gray100)
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 8)
                )
                .padding(.bottom, 10)
                
            }
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
    SetNameView(store: Store(initialState: SetNameCore.State()) {
        SetNameCore()
    })
}
