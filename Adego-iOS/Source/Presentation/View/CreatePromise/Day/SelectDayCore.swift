//
//  SelectDayCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import ComposableArchitecture
import FlowKit
import Foundation

@Reducer
struct SelectDayCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var promiseTitle: String
        var selectedDate = Date()
        var selectedDateString: String = ""
    }
    
    enum Action: ViewAction {
        case navigateToSelectTimeView
        case setValue
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
            case .navigateToSelectTimeView:
                let stringDate = String(describing: state.selectedDate)
                if !stringDate.isEmpty {
                    let formattedDate = formatDate(state.selectedDate)
                    state.selectedDateString = formattedDate
                    print(formattedDate)
                    flow.push(
                        SelectTimeView(
                            store: Store(
                                initialState: SelectTimeCore.State(promiseTitle: state.promiseTitle, selectedDate: formattedDate)
                            ) {
                                SelectTimeCore()
                            }
                        )
                    )
                } else {
                    flow.alert(
                        Alert(title: "날짜를 선택해주세요.")
                    )
                }
                return .none
            
            case .setValue:
                return .none
            case .view(.binding):
                return .none
            }
            
            func formatDate(_ date: Date) -> String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                let dateString = String(describing: date)
                
                if let date = dateFormatter.date(from: dateString) {
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    return dateFormatter.string(from: date)
                }
                return "nil"
            }
        }
    }
}
