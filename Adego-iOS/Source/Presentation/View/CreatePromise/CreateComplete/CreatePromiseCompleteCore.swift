//
//  CreatePromiseCompleteCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import SwiftUI
import ComposableArchitecture
import FlowKit
import Moya

@Reducer
struct CreatePromiseCompleteCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        var place: Place = Place(id: "", name: "", address: "", x: "", y: "", planId: "")
        var date: String = ""
        var isAlarmAvailable: Bool = false
        
        var shereUrl: String = ""
        var id: String = ""
        var promiseTitle: String = "같이 학교갈 팟"
        var promiseDay: String = "2024년 3월 4일"
        var promiseTime: String = "오전 6시 30분"
        var promiseLocation: String = "대구소프트웨어마이스터고등학교"
        
        var promiseResponse: Promise = Promise()
    }
    
    enum Action: ViewAction {
        case onAppear
        case setLink(LinkResponse)
        case returnButton
        case getPromise
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("state.promiseDay", state.promiseResponse.date)
                state.id = state.promiseResponse.id
                state.promiseTitle = state.promiseResponse.name
                state.promiseLocation = state.promiseResponse.place.name
                state.promiseDay = formatDate(state.promiseResponse.date)
                state.promiseTime = formatTime(state.promiseResponse.date)
                
                let promiseRepository = PromiseRepositoryImpl()
                let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                return .run { send in
                    do {
                        let response = try await promiseUseCase.inviteUserToPromise(accessToken: savedAccessToken)
                        await send(.setLink(response))
                    } catch {
                        print("🚫CreatePromiseCompleteCore.inviteUserToPromise error: \(error.localizedDescription)")
                    }
                }
                
            case .setLink(let response):
                state.shereUrl = response.link
                return .none
            case .returnButton:
                flow.popToRoot()
                return .none
                
            case .getPromise:
                return .none
                
            case .view(.binding):
                return .none
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
        }
    }
}
