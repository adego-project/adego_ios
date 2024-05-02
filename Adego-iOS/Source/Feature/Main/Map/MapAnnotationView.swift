//
//  MapAnnotationView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/9/24.
//


import SwiftUI
import MapKit

struct MapAnnotationView: View {
    let imageURL: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "person.fill")
                    .resizable()
            }
            .clipShape(Circle())
        }
        .scaledToFit()
        .frame(width: 40, height: 40)
        .foregroundColor(.white)
        .padding(2)
    }
}

#Preview {
    MapAnnotationView()
}
