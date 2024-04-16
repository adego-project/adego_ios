//
//  ContentView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI

struct ContentView: View {
    @State var hourSelect = 0
    @State var minuteSelect = 0
    
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    
    var body: some View {
        ZStack {
            //            Color.black
            //                .opacity(0.5)
            //                .ignoresSafeArea()
            //                .preferredColorScheme(.light)
            //            Rectangle()
            //                .fill(.white.opacity(1))
            //                .cornerRadius(30)
            //                .frame(width: 300, height: 350)
            //            VStack {
            //                Text("Header")
            //                    HStack(spacing: 0) {
            //                        Picker(selection: $hourSelect, label: Text("")) {
            //                            ForEach(0..<self.hours.count, id: \.self) { index in
            //                                Text("\(self.hours[index])").tag(index)
            //                           }
            //                        }
            //                        .pickerStyle(.wheel)
            //                        .frame(minWidth: 0)
            //                        .compositingGroup()
            //                        .clipped()
            //
            //                        Picker(selection: $minuteSelect, label: Text("")) {
            //                            ForEach(0..<self.minutes.count, id: \.self) { index in
            //                                Text("\(self.minutes[index])").tag(index)
            //                           }
            //                        }
            //                        .offset(x: -15)
            //                        .pickerStyle(.wheel)
            //                        .frame(minWidth: 0)
            //                        .compositingGroup()
            //                        .clipped()
            //                    }
            //            }
            
            
            HStack(spacing: 0) {
                Picker(selection: .constant(3), label: Text("Picker")) {
                    ForEach(0..<self.hours.count, id: \.self) { index in
                        Text("\(self.hours[index])").tag(index)
                    }
                }
                .pickerStyle(.wheel)
                .clipShape(.rect.offset(x: -16))
                .padding(.trailing, -16)
                
                Picker(selection: .constant(3), label: Text("Picker")) {
                    Text("1 oz").tag(1)
                    Text("2 oz").tag(2)
                    Text("3 oz").tag(3)
                    Text("4 oz").tag(4)
                    Text("5 oz").tag(5)
                    Text("6 oz").tag(6)
                }
                .pickerStyle(.wheel)
                .clipShape(.rect.offset(x: 16))
                .clipShape(.rect.offset(x: -16))
                .padding(.leading, -16)
                .padding(.trailing, -16)
                
                Picker(selection: .constant(3), label: Text("Picker")) {
                    Text("1 oz").tag(1)
                    Text("2 oz").tag(2)
                    Text("3 oz").tag(3)
                    Text("4 oz").tag(4)
                    Text("5 oz").tag(5)
                    Text("6 oz").tag(6)
                }
                .pickerStyle(.wheel)
                .clipShape(.rect.offset(x: 32))
                .padding(.leading, -32)
            }
            .padding()
        }
        
    }
}


#Preview {
    ContentView()
}
