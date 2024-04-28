//
//  CreateCompleteView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: CreatePromiseCompleteCore)
struct CreatePromiseCompleteView: View {
    @Perception.Bindable var store: StoreOf<CreatePromiseCompleteCore>
    var body: some View {
        WhiteTitleText(
            title: "약속이 생성됐어요!\n링크를 보내고\n친구들과 함께하세요."
        )
        .lineSpacing(10)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.leading, 16)
        
        VStack(alignment: .leading) {
            Text("\(store.promiseTitle)")
                .font(.wantedSans(24, weight: .regular))
                .foregroundStyle(.white)
                .padding(.bottom, 10)
            
            CustomInfoView(image: "calendar", caption: store.promiseDay)
            
            CustomInfoView(image: "clock", caption: store.promiseTime)
            
            CustomInfoView(image: "calendar", caption: store.promiseLocation)
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
        .padding(.top, 32)
        
        Spacer()
        
        HStack(alignment: .top, spacing: 4) {
            Button {
                
            } label: {
                Text("\(Image(systemName: "square.and.arrow.up")) 링크 공유하기")
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


        
        Button {
            store.send(.returnButton)
        } label: {
            Text("돌아가기 \(Image(systemName: "arrow.right"))")
        }
        .buttonStyle(CustomWhiteRoundedButton())
        .padding(.bottom, 10)
    }
}

#Preview {
    CreatePromiseCompleteView(
        store: Store(
            initialState: CreatePromiseCompleteCore.State()
        ) {
            CreatePromiseCompleteCore()
        }
    )
}
