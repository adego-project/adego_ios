//
//  SelectLocationCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import Foundation
import ComposableArchitecture
import FlowKit
import SwiftUI

@Reducer
struct SelectLocationCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        
        var searchWord: String = ""
        var debouncedText: String = ""
        
        var promiseTitle: String = ""
        var selectedAddress: String = ""
        var selectedDate: String = ""
        
        var debounceTimer: Timer?
        let debounceInterval: TimeInterval = 0.5
        
        var promiseResponse: Promise = Promise()
        
        var serchList: AddressResponse = AddressResponse(documents: [Document]())
    }
    
    enum Action: ViewAction {
        case createPromise(String, String, String)
        case getAddressList
        //        case debouncedTextChanged(String)
        case setSearchList(AddressResponse)
        case setPromiseResponse(Promise)
        case navigateCreatePromiseCompleteView
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.flow) var flow
    
    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .createPromise(let promiseTitle, let selectedAddress, let selectedDate):
                let promiseRepository = PromiseRepositoryImpl()
                let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                return .run { send in
                    do {
                        let response = try await promiseUseCase.createPromise(name: promiseTitle, address: selectedAddress, date: selectedDate)
                        print("✅SelectLocationCore.createPromise: \(response)")
                        await send(.setPromiseResponse(response))
                        await send(.navigateCreatePromiseCompleteView)
                    } catch {
                        print("🚫SelectLocationCore.createPromise error: \(error.localizedDescription)")
                        if let errorResponse = error as? ErrorResponse {
                            if errorResponse.message == "User already has a plan" {
                                flow.alert(
                                    Alert(title: "이미 생성된 약속이 있습니다.",
                                        dismissButton: .default("확인", action: {
                                                flow.popToRoot()
                                            }
                                        )
                                    )
                                )
                            }
                        } else {
                            print("🚫SelectLocationCore.createPromise error: \(error.localizedDescription)")
                        }
                    }
                }
                
            case .getAddressList:
                let searchWord = state.searchWord
                print("searchWord", searchWord)
                let addressRepository =  AddressRepositoryImpl()
                let addressUseCase = AddressUseCase(addressRepository: addressRepository)
                return .run { send in
                    do {
                        let response = try await addressUseCase.searchAddress(searchWord: searchWord)
                        print("✅SelectLocationCore.getAddressList: \(response)")
                        await send(.setSearchList(response))
                    } catch {                            print("🚫SelectLocationCore.getAddressList error: \(error.localizedDescription)")
                    }
                }
                
            case .setSearchList(let response):
                state.serchList = response
                
                return .none
                
            case .setPromiseResponse(let response):
                state.promiseResponse = response
                
                return .none
                
            case .navigateCreatePromiseCompleteView:
                flow.push(
                    CreatePromiseCompleteView(
                        store: Store(
                            initialState: CreatePromiseCompleteCore.State(promiseResponse: state.promiseResponse)
                        ) {
                            CreatePromiseCompleteCore()
                        }
                    )
                )
                return .none
            case .view(.binding):
                
                return .none
            }
        }
    }
}
