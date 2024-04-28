//
//  InvitedAppointmentView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/16/24.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: InvitedAppointmentCore)
struct InvitedAppointmentView: View {
    @Perception.Bindable var store: StoreOf<InvitedAppointmentCore>
    var body: some View {
        WhiteTitleText(
            title: "약속에 초대됐어요.\n하단카드를 통해 확인하세요."
        )
        .lineSpacing(10)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.leading, 16)
        
        VStack {
            profileImage
            
            Text("\(store.name)님이 초대했어요.")
                .font(.wantedSans(14))
                .foregroundStyle(.gray80)
        }
        .padding(.top, 24)
        .padding(.bottom, 16)
        
        inviteCard
        
        Spacer()
        
        HStack(alignment: .top, spacing: 4) {
            Button {
                store.send(.declineInvitation)
            } label: {
                Text("\(Image("Block")) 초대 거부하기")
                    .font(.wantedSans(weight: .regular))
                    .foregroundStyle(.gray100)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 20)
        .padding(.vertical, 12)
        .background(.gray20)
        .clipShape(
            RoundedRectangle(cornerRadius: 100)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 100)
                .inset(by: 0.5)
                .stroke(.gray30, lineWidth: 1)
        )
        .padding(.bottom, 10)
        
        acceptInbitationButton
            .padding(.bottom, 10)
        
    }
}

extension InvitedAppointmentView {
    private var profileImage: some View {
        AsyncImage(url: URL(string: store.imageUrl)) { image in
            image
                .resizable()
        } placeholder: {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .background(.gray60)
                .clipShape(Circle())
        }
    }
    
    private var inviteCard: some View {
        VStack(alignment: .leading) {
            Text("\(store.promiseTitle)")
                .font(.wantedSans(24, weight: .regular))
                .foregroundStyle(.white)
                .padding(.bottom, 10)
            
            CustomInfoView(image: "calendar", caption: store.promiseDay)
            
            CustomInfoView(image: "clock", caption: store.promiseTime)
            
            CustomInfoView(image: "distance", caption: store.promiseLocation)
        }
        .padding(20)
        .frame(width: 343, height: 176)
        .background(.gray20)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(.gray30, lineWidth: 1)
        )
    }
    
    
    private var acceptInbitationButton: AnyView {
        if store.isAppointment {
            return AnyView(notificationButton)
        } else {
            return AnyView(acceptButton)
        }
    }
    
    private var acceptButton: some View {
        Button {
            store.send(.acceptInvitation)
        } label: {
            Text("초대 수락하기 \(Image(systemName: "arrow.right"))")
        }
        .buttonStyle(CustomWhiteRoundedButton())
    }

    private var notificationButton: some View {          
        Text("이미 진행 중이 약속이 있어요.")
                .foregroundStyle(.gray40)
                .frame(width: 343, height: 56)
                .background(.gray30)
                .clipShape(
                    RoundedRectangle(cornerRadius: 8)
                )
    }
}

#Preview {
    InvitedAppointmentView(
        store: Store(
            initialState: InvitedAppointmentCore.State()
        ) {
            InvitedAppointmentCore()
        }
    )
}
