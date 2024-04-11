//
//  MapAnnotationView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/9/24.
//


import SwiftUI
import MapKit

struct MapAnnotationView: View {
    let imageURL: String = "https://wallpapers.com/images/high/intense-harimau-walking-on-grass-m7h2k7q1z815w5zk.webp"
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "person.fill")
                    .resizable()
            }
        }
        .scaledToFit()
        .frame(width: 30, height: 30)
        .font(.headline)
        .foregroundColor(.white)
        .padding(6)
        .clipShape(Circle())
        

    }
}

#Preview {
    MapAnnotationView()
}
