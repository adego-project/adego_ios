//
//  SelectLocationView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import SwiftUI
import ComposableArchitecture

struct SelectLocationView: View {
    @Perception.Bindable var store: StoreOf<SelectLocationCore>
    
    
    var body: some View {
        WithPerceptionTracking {
            VStack(alignment: .leading) {
                WhiteTitleText(title: "만날 장소를 검색해주세요")
                    .padding(.leading, 16)
                
                CustomInputTextField(
                    text: "장소 이름",
                    input: $store.searchWord,
                    placeholder: "만날 장소를 검색해주세요",
                    isFormValid: false
                )
                .padding(.leading, 16)
                .padding(.top, 40)
                .onChange(of: store.searchWord) { newValue in
                        store.send(.getAddressList)
                        
                    print("store.model", store.model)
                }
                
                List(store.model.documents, id: \.id) { index in
                    Button {
                        
                    } label: {
                        VStack(alignment: .leading) {
                            Text(index.addressName)
                                .font(.wantedSans())
                                .foregroundStyle(.gray100)
                            
                            Text(index.roadAddressName)
                                .font(.wantedSans(14))
                                .foregroundStyle(.gray70)
                                .padding(.top, 4)
                        }
                    }
                }
                .padding(.top, 24)
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    SelectLocationView(
        store: Store(
            initialState: SelectLocationCore.State()
        ) {
            SelectLocationCore()
        }
    )
}
