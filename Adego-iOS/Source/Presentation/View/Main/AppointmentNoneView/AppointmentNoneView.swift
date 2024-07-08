//
//  AppointmentNoneView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/29/24.
//

import SwiftUI
import ComposableArchitecture

struct AppointmentNoneView: View {
    @Perception.Bindable var store: StoreOf<AppointmentNoneCore>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("현재 에정 된\n약속이 없어요.")
                    .lineSpacing(10)
                    .font(.wantedSans(24))
                    .foregroundStyle(.gray100)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                Button {
                    
                } label: {
                    Text("약속 생성하기 \(Image(systemName: "arrow.right"))")
                }
                .buttonStyle(CustomWhiteRoundedButton())
                .padding(.top, 20)
                .padding(.bottom, 10)

            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(.black)
            .padding(.horizontal, 20)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
        }
    }
}

#Preview {
    AppointmentNoneView(
        store: Store(
            initialState: AppointmentNoneCore.State()
        ) {
            AppointmentNoneCore()
        }
    )
}
