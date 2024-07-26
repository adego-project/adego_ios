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
        
        var promiseLocation: String = ""
        var isPromiseValid: Bool = false
        var promiseTimeRemaingUntil: String = ""
    }
    
    enum Action: ViewAction {
        case onAppear
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
                return .run { send in
                    let promiseRepository = PromiseRepositoryImpl()
                    let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                    
                    promiseUseCase.getPromise(accessToken: savedAccessToken) { result in
                        switch result {
                        case .success(let response):
                            DispatchQueue.main.async {
                                send(.setValue(response))
                            }
                        case .failure(let error):
                            print("🚫PromisePreviewCore.getPromise error: \(error.localizedDescription)")
                            print(error)
                    }
                    }
                }
            case .setValue(let response):
                print("setValue")
                state.promiseTitle = response.name
                state.promiseLocation = response.place.address
                state.promiseDate = response.date
                setDate(dateString: response.date, state: &state)
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
    
    private func setDate(dateString: String, state: inout State) { //"yyyy-MM-ddTHH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        guard let date = dateFormatter.date(from: dateString) else {
            print("🚫PromisePreviewCore.setDate DateFormatterError")
            return
        }
        
        let now = Date()
        let calendar = Calendar.current
        
        // 날짜 정보
        let dateInfo = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        if let year = dateInfo.year,
           let month = dateInfo.month,
           let day = dateInfo.day,
           let hour = dateInfo.hour,
           let minute = dateInfo.minute {
            state.promiseDay = "\(year)년 \(month)월 \(day)일"
            state.promiseTime = "\(hour)시 \(minute)분"
        }
        
        // 남은 시간
        let remainingUntil = calendar.dateComponents([.day, .hour, .minute], from: now, to: date)
        if let day = remainingUntil.day,
           let hour = remainingUntil.hour,
           let minute = remainingUntil.minute {
            state.promiseTimeRemaingUntil = "\(day)일 \(hour)시간 \(minute)분 뒤 시작돼요"
        }
    }
    
    private func save(response: Promise) {

    }
}
