//
//  SelectLocationCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import Foundation
import ComposableArchitecture

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
        
        var model: AddressResponse = AddressResponse(documents: [Document]())
        
    }
    
    enum Action: ViewAction {
        case createPromise
        case getAddressList
//        case debouncedTextChanged(String)
        case setValue(AddressResponse)
        case navigateToCreatePromiseCompleteView
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
            case .createPromise:
                let promiseRepository = PromiseRepositoryImpl()
                let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                promiseUseCase.createPromise(name: state.promiseTitle, address: state.selectedAddress, date: state.selectedDate) { result in
                    switch result {
                    case .success(let response):
                        print("✅SelectLocationCore.createPromise: \(response)")
                    case .failure(let error):
                        print("🚫SelectLocationCore.createPromise error: \(error.localizedDescription)")
                        print(error)
                    }
                }
                return .none
                
            case .getAddressList:
                let searchWord = state.searchWord
                print("searchWord", searchWord)
                return .run { send in
                    let addressRepository =  AddressRepositoryImpl()
                    let addressUseCase = AddressUseCase(addressRepository: addressRepository)
                    addressUseCase.searchAddress(searchWord: searchWord) { result in
                        switch result {
                        case .success(let response):
                            print("✅SelectLocationCore.getAddressList: \(response)")
                            DispatchQueue.main.async {
                                send(.setValue(response))
                                
                            }
                            print("3")
                            
                        case .failure(let error):
                            print("🚫SelectLocationCore.getAddressList error: \(error.localizedDescription)")
                            print(error)
                        }
                    }
                }
                
            case .setValue(let response):
                state.model = response
                print("4")
                
                return .none
                
            case .navigateToCreatePromiseCompleteView:
                flow.push(
                    CreatePromiseCompleteView(
                        store: Store(
                            initialState: CreatePromiseCompleteCore.State()
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
