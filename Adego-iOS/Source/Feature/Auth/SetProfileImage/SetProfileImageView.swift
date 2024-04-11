//
//  SetProfileImageView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: SetProfileImageCore.self)
struct SetProfileImageView: View {
    @Perception.Bindable var store: StoreOf<SetProfileImageCore>
    
    init(store: StoreOf<SetProfileImageCore>) {
        self.store = store
    }
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .center) {
                Text("본인의 이름을 정해주세요")
                    .font(.wantedSans(24, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.top, 76)
                    .frame(alignment: .leading)
                
                Image(uiImage: store.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(.gray20)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke()
                    )
                
                Button {
                    store.send(.setProfileImage)
                } label: {
                    Text("프로필 사진 설정 \(Image(systemName: "arrow.right"))")
                        .font(.wantedSans())
                        .foregroundStyle(.gray100)
                        .underline()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .sheet(isPresented: $store.isImagePickerShow) {
                    ImagePickerView(result: $store.result, selectedImage: $store.image, sourceType: .photoLibrary)
                }
                
                Spacer()
                
                Button {
                    store.send(.createAccount)
                } label: {
                    Text("생성하기 \(Image(systemName: "arrow.right"))")
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
    }
}

#Preview {
    SetProfileImageView(
        store: Store(
            initialState: SetProfileImageCore.State()
        ) {
            SetProfileImageCore()
        }
    )
}
