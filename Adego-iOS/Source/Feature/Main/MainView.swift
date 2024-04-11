//
//  MainView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import MapKit
import ComposableArchitecture

@ViewAction(for: MainCore.self)
struct MainView: View {
    @Perception.Bindable var store: StoreOf<MainCore>
    
    init(store: StoreOf<MainCore>) {
        self.store = store
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
                    Spacer()
                    
                    locationsPreviewStack
                }
            }
        }
    }
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(locations) { location in
                PromisePreviewView(
                    store: Store(initialState: PromisePreviewCore.State()) {
                        PromisePreviewCore()
                    }, location:  locations.first!
                )
                .frame(maxWidth: .infinity)
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    )
                )
            }
            .onAppear {
                print("locationsPreviewStack")
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
