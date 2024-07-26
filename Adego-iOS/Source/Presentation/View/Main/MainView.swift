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
    @Perception.Bindable private var store: StoreOf<MainCore>
    
    init(store: StoreOf<MainCore>) {
        self._store = Perception.Bindable(store)
    }
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                Map(coordinateRegion: .constant(store.mapRegion ?? MKCoordinateRegion()),
                    showsUserLocation: true,
                    annotationItems: locations,
                    annotationContent: { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        MapAnnotationView()
                            .scaleEffect(store.mapLocation == location ? 1 : 0.7)
                            .clipShape(
                                Circle()
                            )
                            .overlay(
                                Circle()
                                    .stroke()
                                    .foregroundStyle(.gray80)
                            )
                            .onTapGesture {
                                store.send(.updateMapRegion(location))
                            }
                    }
                })
                .preferredColorScheme(.dark)
                .ignoresSafeArea(.all)
                .onAppear {
                    store.send(.findCurrentLocation)
                }
                
                VStack {
                    header
                    
                    Spacer()
                    
                    promisePreviewStack
                }
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
                    .frame(width: 18, height: 18)
            }
            .buttonStyle(CustomStrokeRoundedButtonStyle())
            
        }
        .padding(.horizontal, 16)
    }
    
    private var promisePreviewStack: some View {
        ZStack {
            if store.isHavePromise {
                PromisePreviewView(
                    store: Store(
                        initialState: PromisePreviewCore.State()
                    ) {
                        PromisePreviewCore()
                    }
                )
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    )
                )
                .navigationBarHidden(true)
            } else {
                AppointmentNoneView(
                    store: Store(
                        initialState: AppointmentNoneCore.State()
                    ) {
                        AppointmentNoneCore()
                    }
                )
                
                .frame(maxWidth: .infinity)
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    )
                )
                .navigationBarHidden(true)
            }
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
