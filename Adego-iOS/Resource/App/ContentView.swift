//
//  ContentView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var currentMonth: Date = Date()

    var body: some View {
        VStack {
            Text("약속날을 정해주세요.")
                .font(.title)
                .foregroundColor(.white)
                .padding()
            
            HStack {
                Button(action: { withAnimation { previousMonth() } }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
                
                Text(monthYearString(from: currentMonth))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                Button(action: { withAnimation { nextMonth() } }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 10)
            
            daysOfWeekView()
            
            VStack {
                ForEach(weeksInMonth(), id: \.self) { week in
                    HStack {
                        ForEach(week, id: \.self) { date in
                            calendarDayView(date: date, currentMonth: currentMonth, isSelected: isSelected(date: date))
                                .onTapGesture {
                                    withAnimation {
                                        selectedDate = date
                                    }
                                }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func daysOfWeekView() -> some View {
            let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
            
            return HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
            }
        }

        func calendarDayView(date: Date, currentMonth: Date, isSelected: Bool) -> some View {
            let dayString: String = {
                let formatter = DateFormatter()
                formatter.dateFormat = "d"
                return formatter.string(from: date)
            }()
            
            let isCurrentMonth: Bool = {
                Calendar.current.isDate(date, equalTo: currentMonth, toGranularity: .month)
            }()
            
            return Text(dayString)
                .foregroundColor(isSelected ? .black : (isCurrentMonth ? .white : .gray))
                .padding(8)
                .background(isSelected ? Color.white : Color.clear)
                .clipShape(Circle())
                .frame(maxWidth: .infinity)
        }
    
    private func previousMonth() {
        currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) ?? Date()
    }
    
    private func nextMonth() {
        currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) ?? Date()
    }
    
    private func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월"
        return formatter.string(from: date)
    }
    
    private func weeksInMonth() -> [[Date]] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: currentMonth),
              let monthFirstWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.start)
        else {
            return []
        }
        
        var weeks: [[Date]] = []
        var startOfWeek = monthFirstWeek.start
        
        while startOfWeek < monthInterval.end {
            let week = (0..<7).compactMap { day -> Date? in
                Calendar.current.date(byAdding: .day, value: day, to: startOfWeek)
            }
            weeks.append(week)
            startOfWeek = Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: startOfWeek) ?? Date()
        }
        
        return weeks
    }
    
    private func isSelected(date: Date) -> Bool {
        Calendar.current.isDate(date, inSameDayAs: selectedDate)
    }
}

#Preview {
    ContentView()
}
