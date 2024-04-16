//
//  SelectTimeView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: SelectTimeCore)
struct SelectTimeView: View {
    @Perception.Bindable var store: StoreOf<SelectTimeCore>
    
    let ampms = ["오전", "오후"]
    let hours = Array(0...11)
    let minutes = Array(0...59)
    
    var body: some View {
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

                
            
            Text("\(Image(systemName: "calendar")) \(store.year)년 \(store.month)월 \(store.day)일")
                .font(.wantedSans())
                .foregroundStyle(.gray100)
                .padding(.top, 4)
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)

            
            timePicker
                .padding(.top, 40)
            
            Spacer()
            
            Button {
                
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
extension SelectTimeView {
    var timePicker: some View {
        HStack(spacing: 0) {
            Picker(selection: $store.amPM, label: Text("")) {
                ForEach(0..<self.ampms.count, id: \.self) { index in
                    let ampm = ampms[index]
                    Text("\(ampm)")
                        .tag("\(ampm)")
                        .font(.wantedSans(24))
                }
            }
            .pickerStyle(.wheel)
            .clipShape(.rect.offset(x: -16))
            .padding(.trailing, -16)
            
            Picker(selection: $store.hours, label: Text("")) {
                ForEach(0..<self.hours.count, id: \.self) { index in
                    Text("\(self.hours[index])")
                        .tag("\(index)")
                        .font(.wantedSans(24))
                }
            }
            .pickerStyle(.wheel)
            .clipShape(.rect.offset(x: 16))
            .clipShape(.rect.offset(x: -16))
            .padding(.leading, -16)
            .padding(.trailing, -16)
            
            Picker(selection: $store.minute, label: Text("")) {
                ForEach(0..<self.minutes.count, id: \.self) { index in
                    Text("\(self.minutes[index])")
                        .tag("\(index)")
                        .font(.wantedSans(24))
                }
            }
            .pickerStyle(WheelPickerStyle())
            .clipShape(.rect.offset(x: 32))
            .padding(.leading, -32)
        }
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
