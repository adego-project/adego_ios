//
//  SelectTimeCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import ComposableArchitecture

@Reducer
struct SelectTimeCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var promiseTitle: String = ""
        var selectTime: String = ""
        var amPM: String = "오전"
        var hours: String = "4"
        var minute: String = "14"
        var selectedDate: String = ""
        var selectedAddress: String = ""
        var formattedDate: String = ""
    }
    
    enum Action: ViewAction {
        case navigateToSelectLocationView
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
            case .navigateToSelectLocationView:
                let formattedTime = formatTime(amPM: state.amPM, hours: state.hours, minute: state.minute)
                print(formattedTime)
                flow.push(
                    SelectLocationView(
                        store: Store(
                            initialState: SelectLocationCore.State(promiseTitle: state.promiseTitle, selectedDate: state.formattedDate)
                        ) {
                            SelectLocationCore()
                        }
                    )
                )
                return .none
            case .setValue:

                return .none
            case .view(.binding):
                return .none
            }
            
            func formatTime(amPM: String, hours: String, minute: String) -> String {
                guard let intHours = Int(hours) else {
                    return "Invalid hours"
                }
                
                var formattedHours: String
                
                if amPM == "오전" {
                    formattedHours = intHours == 12 ? "00" : String(format: "%02d", intHours)
                } else if amPM == "오후" {
                    formattedHours = intHours == 12 ? "12" : String(format: "%02d", intHours + 12)
                } else {
                    return "Invalid AM/PM value"
                }
                
                let formattedTime = "\(state.selectedDate) \(formattedHours):\(minute):00"
                return formattedTime
            }
        }
    }
}
