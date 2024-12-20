//
//  MainView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import MapKit
import ComposableArchitecture

struct MainView: View {
    @Perception.Bindable var store: StoreOf<MainCore>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
//                MapView(
//                    store: Store(
//                        initialState: MapCore.State(
//                            MapEnvironment(
//                                locationManager: LocationManager(),
//                                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
//                            ) {
//                                MapCore()
//                            }
//                        )
//                    )
//                )
                
                VStack {
                    header
                    
                    Spacer()
                    
                    promisePreviewStack
                }
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

extension MainView {
    private var header: some View {
        HStack {
            Image("Union")
                .resizable()
                .frame(width: 28, height: 28)
            
            Spacer()
            
            Button {
                store.send(.navigateToSettingView)
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            .buttonStyle(CustomStrokeRoundedButtonStyle())
        }
        .padding(.horizontal, 16)
    }
    
    private var promisePreviewStack: some View {
        ZStack {
            Group {
                if store.isHavePromise {
                    PromisePreviewView(
                        store: Store(
                            initialState: PromisePreviewCore.State()
                        ) {
                            PromisePreviewCore()
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                } else {
                    AppointmentNoneView(
                        store: Store(
                            initialState: AppointmentNoneCore.State()
                        ) {
                            AppointmentNoneCore()
                        }
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            
            .navigationBarHidden(true)
            .transition(
                .asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                )
            )
        }
        .onAppear {
            print(store.isHavePromise)
        }
        .onChange(of: store.isHavePromise) { havePromise in
            print(store.isHavePromise)
            
        }
    }
}

#Preview {
    MainView(
        store: Store(
            initialState: MainCore.State()
        ) {
            MainCore()
        }
    )
}
