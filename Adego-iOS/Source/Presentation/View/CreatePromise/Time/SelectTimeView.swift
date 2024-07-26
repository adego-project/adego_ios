//
//  SelectTimeView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import SwiftUI
import ComposableArchitecture

struct SelectTimeView: View {
    @Perception.Bindable var store: StoreOf<SelectTimeCore>
    
    let ampms = ["오전", "오후"]
    let hours = Array(0...11)
    let minutes = Array(0...59)
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                WhiteTitleText(
                    title: "약속 시간을 정해주세요."
                )
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("약속 시간 이후 30분 동안 알림 발송이 가능합니다.")
                    .font(.wantedSans())
                    .foregroundStyle(.gray60)
                    .padding(.top, 4)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("약속 일자")
                    .font(.wantedSans(14))
                    .foregroundStyle(.gray60)
                    .padding(.top, 32)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                
                Text("\(Image(systemName: "calendar")) \(store.selectedDate)")
                    .font(.wantedSans())
                    .foregroundStyle(.gray100)
                    .padding(.top, 4)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                timePickerContainer
                    .padding(.top, 40)
                    .onChange(of: store.amPM) { _ in
                        
                    }
                
                Spacer()
                
                Button {
                    store.send(.navigateToSelectLocationView)
                } label: {
                    Text("약속 생성하기 \(Image(systemName: "arrow.right"))")
                        .frame(width: 319, height: 56)
                        .foregroundStyle(.black)
                        .background(.gray100)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                }
                .padding(.bottom, 16)
            }
        }
    }
}


extension SelectTimeView {
    var timePickerContainer: some View {
        HStack(spacing: 0) {
            createPicker(
                selection: $store.amPM,
                data: ampms,
                padding: EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: -16
                ),
                offset: -16
            )
            
            createPicker(
                selection: $store.hours,
                data: hours.map { String($0) },
                padding: EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                ),
                offset: 0
            )
            .clipShape(.rect.offset(x: 32))
            .clipShape(.rect.offset(x: -32))
            .padding(.leading, -32)
            .padding(.trailing, -32)
            
            //
            createPicker(
                selection: $store.minute,
                data: minutes.map { String($0) },
                padding: EdgeInsets(
                    top: 0, leading: -32, bottom: 0, trailing: 0
                ),
                offset: 32
            )
        }
    }
    
    private func createPicker<T: Hashable>(
        selection: Binding<T>,
        data: [String],
        padding: EdgeInsets,
        offset: CGFloat
    ) -> some View {
        Picker(selection: selection, label: Text("")) {
            ForEach(data.indices, id: \.self) { index in
                Text(data[index])
                    .tag(data[index])
                    .font(.wantedSans(24))
            }
        }
        .pickerStyle(WheelPickerStyle())
        .clipShape(Rectangle().offset(x: offset))
        .padding(padding)
    }
}

#Preview {
    SelectTimeView(
        store: Store(
            initialState: SelectTimeCore.State()
        ) {
            SelectTimeCore()
        }
    )
}
