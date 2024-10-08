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
                shereButton
            } else {
                sendNotificationViewButton
            }
        }
    }
    
    private var shereButton: some View {
        HStack {
            Button {
                store.isPromiseValid.toggle()
            } label: {
                Text(store.promiseTimeRemaingUntil)
                    .foregroundStyle(.white)
                    .frame(width: 259, height: 56)
                    .background(.gray30)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
            }
            
            Button {
                
            } label: {
                VStack {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                }
                .frame(width: 56, height: 56)
                .buttonStyle(
                    CustomWhiteRoundedButton()
                )
            }
        }
    }
    
    
    private var sendNotificationViewButton: some View {
        Button {
            store.isPromiseValid.toggle()
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
