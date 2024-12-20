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
                Color.black
            }
            .onAppear {
                store.send(.startTimer)
            }
            .onDisappear {
                store.send(.stopTimer)
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
