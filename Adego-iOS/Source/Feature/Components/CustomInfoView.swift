//
//  CustomInfoView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/16/24.
//

import SwiftUI

struct CustomInfoView: View {
    let image: String
    let caption: String
    var body: some View {
            HStack {
                switch image {
                case "calendar", "clock":
                    Image(systemName: "\(image)")
                        .foregroundStyle(.gray60)
                        .frame(width: 20, height: 20)
                default:
                    Image("\(image)")
                        .frame(width: 20, height: 20)
                }
                Text("\(caption)")
                    .font(.wantedSans(16))
                    .foregroundStyle(.gray100)
                
                Spacer()
            }
            .padding(.bottom, 8)
        }
}
