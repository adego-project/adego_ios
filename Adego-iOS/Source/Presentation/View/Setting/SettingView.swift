//
//  SettingView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/12/24.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {
    @Perception.Bindable var store: StoreOf<SettingCore>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                WhiteTitleText(title: "설정")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.bottom, 32)
                
                VStack {
                    HStack {
                        VStack {
                            profileImage
                            
                            Button {
                                
                            } label: {
                                Text("사진 교체 \(Image(systemName: "arrow.right"))")
                                    .font(.wantedSans(14))
                                    .foregroundStyle(.white)
                                    .underline()
                            }
                        }
                        .padding(.leading, 16)
                        
                        Text(store.name)
                            .font(.wantedSans(24))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Button {
                            store.send(.navigateToEditView)
                        } label: {
                            Text("수정")
                                .font(.wantedSans())
                                .foregroundStyle(.white)
                                .underline()
                        }
                        .padding(.trailing, 24)
                    }
                    
                    Divider()
                        .foregroundStyle(.gray40)
                        .padding(.vertical, 32)
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading) {
                        Text("계정")
                            .font(.wantedSans(14, weight: .midium))
                            .foregroundStyle(.gray60)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        
                        button(
                            action: store.send(.showLogoutAlert),
                               text: "계정 로그아웃"
                        )
                        .padding(.vertical, 16)
                        
                        button(
                            action: store.send(.showSecessionAlert),
                               text: "계정 탈퇴"
                        )
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 20)
                .navigationBarHidden(false)
            }
        }
    }
}

extension SettingView {
    private var profileImage: some View {
        AsyncImage(
            url: URL(
                string: store.imageUrl
            )
        ) { image in
            image
                .resizable()
        } placeholder: {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundStyle(.gray80)
                .clipShape(
                    Circle()
                )
        }
    }
    private func button(
        action: StoreTask,
        text: String
    ) -> some View {
        Button {
            action
        } label: {
            Text(text)
                .font(.wantedSans())
                .underline()
                .foregroundStyle(.gray70)
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
