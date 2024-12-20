//
//  PromisePreviewCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/11/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PromisePreviewCore: Reducer {
    var promiseModel: Promise?
    
    @ObservableState
    struct State: Equatable {
        var promiseTitle: String = ""
        var promiseDate: String = ""
        var promiseDay: String = ""
        var promiseTime: String = ""
        
        var promiseUrl: String = ""
        
        var promiseLocation: String = ""
        var isPromiseValid: Bool = false
        var promiseTimeRemaingUntil: String = ""
    }
    
    enum Action: ViewAction {
        case onAppear
        case compareDate(Promise)
        case setLink(LinkResponse)
        case navigateToSendNotificationView
        case setValue(Promise)
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
            case .onAppear:
                let promiseRepository = PromiseRepositoryImpl()
                let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                return .run { send in
                    do {
                        
                        let promiseResponse = try await promiseUseCase.getPromise(accessToken: savedAccessToken)
                        await send(.setValue(promiseResponse))
                        await send(.compareDate(promiseResponse))
                        
                        let linkResponse = try await promiseUseCase.inviteUserToPromise(accessToken: savedAccessToken)
                        await send(.setLink(linkResponse))
                        
                    } catch {
                        print("🚫PromisePreviewCore.getPromise error: \(error.localizedDescription)")
                        print(error)
                    }
                   
                }
                
            case .compareDate(let promiseResponse):
                if let promiseDate = formatDateObject(from: promiseResponse.date) {
                    let currentDate = Date()
                    
                    if currentDate > promiseDate {
                        state.isPromiseValid = true
                    } else {
                        state.isPromiseValid = false
                    }
                }
                return .none
            case .setLink(let linkResponse):
                state.promiseUrl = linkResponse.link
                return .none
            case .setValue(let response):
                state.promiseTitle = response.name
                state.promiseLocation = response.place.address
                state.promiseDate = response.date
                state.promiseDay = formatDate(response.date)
                state.promiseTime = formatTime(response.date)
//                state.promiseUrl = response
                return .none
                
            case .navigateToSendNotificationView:
                flow.push(
                    SendNotificationView(
                        store: Store(
                            initialState: SendNotificationCore.State()
                        ) {
                            SendNotificationCore()
                        }
                    )
                )
                return .none
            case .view(.binding):
                return .none
            }
        }
    }
    
    func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            return dateFormatter.string(from: date)
        }
        
        return "날짜를 가져오는데에 실패하였습니다."
    }

    
    func formatTime(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "HH시 mm분"
            return dateFormatter.string(from: date)
        }
        return "시간를 가져오는데에 실패하였습니다."
    }
    
    private func save(response: Promise) {
        
    }
    
    func formatDateObject(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
}
