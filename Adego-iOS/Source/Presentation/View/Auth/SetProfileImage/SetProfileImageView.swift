//
//  SetProfileImageView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import SwiftUI
import ComposableArchitecture

struct SetProfileImageView: View {
    @Perception.Bindable private var store: StoreOf<SetProfileImageCore>
    
    init(store: StoreOf<SetProfileImageCore>) {
        self.store = store
    }
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .center) {
                WhiteTitleText(
                    title: "본인의 사진을 설정해주세요"
                )
                
                Image(uiImage: store.profileImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(.gray20)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke()
                    )
                    .onChange(of: store.base64String) { result in
                        store.send(.refreshProfileImage)
                    }
                
                Button {
                    store.send(.navigate(store.result, store.selectedImage))
                } label: {
                    Text("프로필 사진 설정 \(Image(systemName: "arrow.right"))")
                        .font(.wantedSans())
                        .foregroundStyle(.gray100)
                        .underline()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                Spacer()
                
                Button {
                    store.send(.createAccount)
                } label: {
                    Text("생성하기 \(Image(systemName: "arrow.right"))")
                    
                }
                .buttonStyle(CustomWhiteRoundedButton())
                .padding(.bottom, 10)
            }
            
            .onAppear {
                store.send(.refreshProfileImage)
            }
        }
    }
}

