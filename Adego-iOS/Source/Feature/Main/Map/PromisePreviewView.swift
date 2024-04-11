//
//  PromisePreviewView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/11/24.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: PromisePreviewCore.self)
struct PromisePreviewView: View {
    @Perception.Bindable var store: StoreOf<PromisePreviewCore>
    
    let location: Location
    
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

                    makeInfo("calendar", caption: store.promiseDay)

                    makeInfo("clock", caption: store.promiseTime)

                    makeInfo("distance", caption: store.promiseLocation)

                }
                .padding(.horizontal, 20)

                makeNotificationButton
               
            }
            .frame(maxWidth: .infinity, maxHeight: 260)
            .background(.black)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .padding(.horizontal, 20)

        }
    }
}

extension PromisePreviewView {
    private func makeInfo(
        _ image: String,
        caption: String
    ) -> some View {
        HStack {
            switch image {
            case "calendar", "clock":
                Image(systemName: "\(image)")
                    .foregroundStyle(.gray60)
                    .frame(width: 20, height: 20)
            default:
                Image("\(image)")
                    .frame(width: 20, height: 20)
            }
            Text("\(caption)")
                .font(.wantedSans(16))
                .foregroundStyle(.gray100)
            
            Spacer()
        }
        .padding(.bottom, 8)
    }
    
    private var makeNotificationButton: some View {
        HStack {
            if store.isPromiseValid {
                Button {
                    store.isPromiseValid.toggle()
                } label: {
                    Text(store.promiseTimeRemaingUntil)
                        .foregroundStyle(.white)
                        .frame(width: 259, height: 56)
                        .background(.gray30)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.white)
                        
                    }
                    .frame(width: 56, height: 56)
                    .background(.gray20)
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 8)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke()
                        .foregroundStyle(.gray30)
                )
            } else {
                Button {
                    store.isPromiseValid.toggle()
                } label: {
                    Text("알림 울리러 가기 \(Image(systemName: "arrow.right"))")
                        .foregroundStyle(.gray10)
                        .frame(width: 319, height: 56)
                        .background(.white)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .animation(.easeInOut, value: store.isPromiseValid)
    }
}

#Preview {
    PromisePreviewView(
        store: Store(
            initialState: PromisePreviewCore.State()
        ) {
            PromisePreviewCore()
        }, location:  locations.first!
    )
}
