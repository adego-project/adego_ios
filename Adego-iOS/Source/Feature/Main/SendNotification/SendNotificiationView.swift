//
//  SendNotificationView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/16/24.
//

import SwiftUI
import ComposableArchitecture
import WrappingHStack

@ViewAction(for: SendNotificationCore)
struct SendNotificationView: View {
    @Perception.Bindable var store: StoreOf<SendNotificationCore>
    var body: some View {
        WithPerceptionTracking {
            VStack {
                WhiteTitleText(
                    title: "시간이 되었습니다.\n이젠 알림을 보내보세요."
                )
                .lineSpacing(10)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("프로필 클릭 시 해당 유저에게 알림이 발송됩니다.")
                    .font(.wantedSans())
                    .foregroundStyle(.gray60)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                userList
            }
        }
    }
}

extension SendNotificationView {
    private var userList: some View {
        ScrollView {
            WrappingHStack(store.userName) { index in
                    Button {
                        
                    } label: {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .background(.gray60)
                            
                                .clipShape(Circle())
                            
                            Text("알파 메일 최시훈")
                                .font(.wantedSans(14))
                                .foregroundStyle(.gray80)
                        }
                        .frame(width: 167.5, height: 64)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.vertical, 16)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    SendNotificationView(
        store: Store(
            initialState: SendNotificationCore.State()
        ) {
            SendNotificationCore()
        }
    )
}
