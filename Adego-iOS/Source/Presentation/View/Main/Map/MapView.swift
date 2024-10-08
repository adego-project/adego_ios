//
//  MapView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/10/24.
//

import SwiftUI
import ComposableArchitecture
import MapKit

struct MapView: View {
    @Perception.Bindable var store: StoreOf<MapCore>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                Map(coordinateRegion: .constant(store.mapRegion),
                    showsUserLocation: true,
                    annotationItems: store.locations,
                    annotationContent: { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        MapAnnotationView()
                            .scaleEffect(store.mapLocation == location ? 1 : 0.7)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke()
                                    .foregroundStyle(.gray80)
                            )
                            .onTapGesture {
                                store.send(.updateMapRegion(location))
                            }
                        
//                            mapDistanceView
//                                .scaleEffect(store.mapLocation == location ? 1 : 0.7)
//                                .clipShape(Circle())
//                                .overlay(
//                                    Circle()
//                                        .stroke()
//                                        .foregroundStyle(.blue)
//                                )
                    }
                })
                .preferredColorScheme(.dark)
                .ignoresSafeArea(.all)
                .onAppear {
                    store.send(.findCurrentLocation)
                }
            }
        }
    }
}

extension MapView {
    private var mapDistanceView: some View {
        VStack(spacing: 0) {
            
            Image("distance")
                .foregroundStyle(.black)
                .clipShape(Circle())
        }
        .scaledToFit()
        .frame(width: 40, height: 40)
        .foregroundColor(.white)
        .padding(2)
    }
}
