//
//  SettingView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/12/24.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: SettingCore.self)
struct SettingView: View {
    @Perception.Bindable var store: StoreOf<SettingCore>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                WhiteTitleText(title: "설정")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                VStack {
                    HStack {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .foregroundStyle(.gray80)
                                .frame(width: 48, height: 48)
                                .clipShape(
                                    Circle()
                                )
                            
                            Button {
                                
                            } label: {
                                Text("사진 교체 \(Image(systemName: "arrow.right"))")
                                    .font(.wantedSans(14))
                                    .foregroundStyle(.white)
                                    .underline()
                            }
                        }
                        .padding(.leading, 16)
                        
                        Text("알파 메일 최시훈")
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
                        
                        Button {
                            store.send(.showLogoutAlert)
                        } label: {
                            Text("계정 로그아웃")
                                .font(.wantedSans())
                                .underline()
                                .foregroundStyle(.gray70)
                        }
                        .padding(.vertical, 16)
                        
                        Button {
                            store.send(.showSecessionAlert)
                        } label: {
                            Text("계정 탈퇴")
                                .font(.wantedSans())
                                .underline()
                                .foregroundStyle(.gray70)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 20)
                .navigationBarHidden(false)
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
