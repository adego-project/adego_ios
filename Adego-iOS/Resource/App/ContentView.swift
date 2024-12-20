//
//  ContentView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import ComposableArchitecture
struct ContentView: View {
    @State private var confirmDialogShowing: Bool = false
    @State private var rating: Float = 0
    @State private var contentInput: String = ""
    @State private var contentInputLengthCount: String = "0/1000"
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVStack (spacing: 36) {
                            VStack(alignment: .center, spacing: 4) {
                                Text("다른 사람들에게도 이 아티스트의")
                                Text("공연이 어땠는지 들려주세요!")
    
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 20)

                            VStack(alignment: .center, spacing: 0) {
                                Color.yellow
                                  .onChange(of: rating) { newRating in
                                    print(newRating)
                                  }
                                  .frame(width: 360, height: 40)
                                
                                Text("별점을 선택해주세요.")
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            
                            VStack(spacing: 0) {
                                ZStack(alignment: .bottomTrailing) {
                                    Color.green
                                    .frame(maxWidth: .infinity, maxHeight: 200)

                                    Text(reverseAttributedString($contentInputLengthCount.wrappedValue, "/1000"))
                                        .foregroundStyle(.white)
                                        .frame(alignment: .bottomTrailing)
                                        .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 10))
                                }
                                .frame(maxWidth: .infinity, maxHeight: 200)

                            }
                            .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            confirmDialogShowing = true
                        }) {
                            Text("공연 종료 확인")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .padding(.init(top: 0, leading: 18, bottom: 20, trailing: 18))
                    }
                    .frame(height: 52)
                    .padding(.horizontal, 18)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundNormal").ignoresSafeArea(.container, edges: .all))
        .environment(\.colorScheme, .dark)
    }
    
    private func reverseAttributedString(_ baseText: String, _ removeAccentText: String) -> AttributedString {
        var text: AttributedString = .init(stringLiteral: "\(baseText)")
        
        let colorAccentRange = text.range(of: removeAccentText)!
        
        text[colorAccentRange].foregroundColor = Color.init(white: 1 - 0.22)
        
        return text
    }
}

#Preview {
    ContentView()
}
