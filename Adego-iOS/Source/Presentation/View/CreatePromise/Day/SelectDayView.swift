//
//  SelectDayView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import SwiftUI
import ComposableArchitecture

struct SelectDayView: View {
    @Perception.Bindable var store: StoreOf<SelectDayCore>
    
    var body: some View {
        WithPerceptionTracking {
            //        ScrollView {
            VStack {
                WhiteTitleText(
                    title: "약속날을 정해주세요"
                )
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                DatePicker("약속날을 선택해주세요", selection: $store.date)
                    .datePickerStyle(.graphical)
                    .tint(.gray70)
                
                Spacer()
                
                Button {
                    store.send(.navigateToSelectTimeView)
                } label: {
                    Text("다음 \(Image(systemName: "arrow.right"))")
                }
                .buttonStyle(CustomWhiteRoundedButton())
                .padding(.bottom, 10)
                
            }
//        }
        }
    }
}

#Preview {
    SelectDayView(
        store: Store(
            initialState: SelectDayCore.State()
        ) {
            SelectDayCore()
        }
    )
}
