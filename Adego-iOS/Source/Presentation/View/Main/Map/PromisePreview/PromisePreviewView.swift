//
//  PromisePreviewView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/11/24.
//

import SwiftUI
import ComposableArchitecture

struct PromisePreviewView: View {
    @Perception.Bindable var store: StoreOf<PromisePreviewCore>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("현재 약속")
                        .font(.wantedSans(14))
                        .foregroundStyle(.gray70)
                        .padding(.bottom, -8)
                    
                    Text(store.promiseTitle)
                        .font(.wantedSans(24))
                        .foregroundStyle(.gray100)
                    
                    CustomInfoView(image: "calendar", caption: store.promiseDay)
                    
                    CustomInfoView(image: "clock", caption: store.promiseTime)
                    
                    CustomInfoView(image: "distance", caption: store.promiseLocation)
                }
                .padding(.horizontal, 20)
                
                makeNotificationButton
            }
            .frame(maxWidth: .infinity, maxHeight: 260)
            .padding(.horizontal, 10)
            .background(.black)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .onAppear {
                store.send(.onAppear)
                
                print(store.promiseTitle,
                      store.promiseLocation,
                      store.promiseDay
                )
            }
        }
    }
}

extension PromisePreviewView {
    private var makeNotificationButton: some View {
        HStack {
            if store.isPromiseValid {
                shareButton
            } else {
                sendNotificationViewButton
            }
        }
    }
    
    private var shareButton: some View {
        HStack {
            Text(store.promiseTimeRemaingUntil)
                .foregroundColor(.white)
                .frame(width: 259, height: 56)
                .background(Color("gray30"))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            // ShareLink for sharing a URL
            if let url = URL(string: store.promiseUrl) {
                ShareLink(
                    item: url,
                    subject: Text("링크를 공유하고 친구를 깨우세요!"),
                    message: Text(store.promiseUrl)
                ) {
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                    .frame(width: 56, height: 56)
                    .background(Color("gray20"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                Color("gray30"),
                                lineWidth: 1
                            )
                    )
                    .buttonStyle(CustomWhiteRoundedButton())
                }
                .frame(alignment: .center)
            }
        }
    }
    
    
    private var sendNotificationViewButton: some View {
        Button {
            store.send(.navigateToSendNotificationView)
        } label: {
            Text("알림 울리러 가기 \(Image(systemName: "arrow.right"))")
                .foregroundStyle(.gray10)
                .frame(width: 319, height: 56)
                .background(.white)
        }
        .buttonStyle(CustomWhiteRoundedButton())
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
    }
}

#Preview {
    PromisePreviewView(
        store: Store(
            initialState: PromisePreviewCore.State()
        ) {
            PromisePreviewCore()
        }
    )
}
