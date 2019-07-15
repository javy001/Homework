//
//  CalendarView.swift
//  Homework
//
//  Created by Javier Quintero on 7/12/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class CalendarView: UIView {

    let calendar = Calendar(identifier: .gregorian)
    var selectedDay = Date()
    var month: Int?
    var year: Int?
    let dateformatter = DateFormatter()
    var selectedButton: DayButton?
    let monthLabel = UILabel()
    let nextButton = UIButton()
    var days: [DayButton] = []
    var dayLabels: [UILabel] = []
    var firstDate: Date?
    var lastDate: Date?
    var color = 0
    let style = AppStyle()
    var superWidth: CGFloat?
    
    
    func updateData(seedDate: Date) {
        month = calendar.component(.month, from: seedDate)
        year = calendar.component(.year, from: seedDate)
        dateformatter.dateFormat = "MMMM"
        if month != calendar.component(.month, from: selectedDay) {
            selectedButton?.backgroundColor = .white
            selectedButton?.setTitleColor(UIColor.black.withAlphaComponent(0.7), for: .normal)
        }
        else {
            selectedButton?.backgroundColor = style.backgroundColors[color]
            selectedButton?.setTitleColor(style.textColors[color], for: .normal)
        }
        let monthString = dateformatter.string(from: seedDate)
        monthLabel.text = monthString
        
        let numDays = genNumDays(month: month!, year: year!)
        let firstWeekDay = genFirstWeekDay(startDate: seedDate)
        dateformatter.dateFormat = "yyyy-MM-dd"
        var i = 1
        for button in days {
            if i >= firstWeekDay && i < (numDays + firstWeekDay) {
                let j = firstWeekDay - 1
                let ds = "\(year!)-\(month!)-\(i-j)"
                button.day = i - j
                button.date = dateformatter.date(from: ds)!
                if i == firstWeekDay {
                    firstDate = button.date
                }
                lastDate = button.date
                button.setTitle("\(i - j)", for: .normal)
                if button != selectedButton {
                    button.setTitleColor(UIColor.black.withAlphaComponent(0.7), for: .normal)
                }
                
            }
            else {
                button.date = nil
                button.day = nil
                button.setTitle(nil, for: .normal)
            }
            i += 1
        }
        
    }
    
    func genCalendar(seedDate: Date) {
        
        let margin = (superWidth! - 7 * 30)/8
        month = calendar.component(.month, from: seedDate)
        year = calendar.component(.year, from: seedDate)
        dateformatter.dateFormat = "MMMM"
        let monthString = dateformatter.string(from: seedDate)
        monthLabel.text = monthString
        
        self.addSubview(monthLabel)
        
        monthLabel.textAlignment = .center
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        monthLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        monthLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        monthLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        nextButton.setTitle(">", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.addTarget(self, action: #selector(nextMonth(_:)), for: .touchUpInside)
        self.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1 * margin).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: monthLabel.bottomAnchor).isActive = true
        
        let prevButton = DayButton()
        prevButton.setTitle("<", for: .normal)
        prevButton.setTitleColor(.black, for: .normal)
        prevButton.addTarget(self, action: #selector(prevMonth(_:)), for: .touchUpInside)
        self.addSubview(prevButton)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        prevButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        prevButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin).isActive = true
        prevButton.bottomAnchor.constraint(equalTo: monthLabel.bottomAnchor).isActive = true
        
        
        let daystrings = [
            "S",
            "M",
            "T",
            "W",
            "T",
            "F",
            "S"
        ]
        
        
        var i = 0
        for day in daystrings {
            let dayLabel = UILabel()
            dayLabel.text = day
            dayLabel.textColor = UIColor.black.withAlphaComponent(0.7)
            dayLabel.textAlignment = .center
            dayLabels.append(dayLabel)
            self.addSubview(dayLabel)
            dayLabel.translatesAutoresizingMaskIntoConstraints = false
            if i == 0 {
                dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin).isActive = true
            }
            else {
                dayLabel.leadingAnchor.constraint(equalTo: dayLabels[i-1].trailingAnchor, constant: margin).isActive = true
            }
            dayLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 3).isActive = true
            dayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            dayLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
            i += 1
        }
        
        let numDays = genNumDays(month: month!, year: year!)
        let firstWeekDay = genFirstWeekDay(startDate: seedDate)
        
        let hLine = UIView()
        self.addSubview(hLine)
        hLine.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        hLine.translatesAutoresizingMaskIntoConstraints = false
        hLine.topAnchor.constraint(equalTo: dayLabels[0].bottomAnchor, constant: 3).isActive = true
        hLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin).isActive = true
        hLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1 * margin).isActive = true
        hLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        dateformatter.dateFormat = "yyyy-M-dd"
        for i in 1...42 {
            let button = DayButton()
            button.addTarget(self, action: #selector(selectDay(_:)), for: .touchUpInside)
            if i >= firstWeekDay && i < (numDays + firstWeekDay) {
                let j = firstWeekDay - 1
                let ds = "\(year!)-\(month!)-\(i-j)"
                button.day = i - j
                let date = dateformatter.date(from: ds)!
                button.date = date
                if ds == dateformatter.string(from: selectedDay) {
                    button.backgroundColor = style.backgroundColors[color]
                    button.setTitleColor(style.textColors[color], for: .normal)
                    selectedButton = button
                }
                else {
                    button.setTitleColor(UIColor.black.withAlphaComponent(0.7), for: .normal)
                }
                if i == firstWeekDay {
                    firstDate = button.date
                }
                lastDate = button.date
                button.setTitle("\(i - j)", for: .normal)
            }
            days.append(button)
        }
        
        i = 0
        for day in days {
            self.addSubview(day)
            day.layer.cornerRadius = 15
            day.translatesAutoresizingMaskIntoConstraints = false
            
            if i <= 6 {
                day.topAnchor.constraint(equalTo: hLine.bottomAnchor, constant: 3).isActive = true
                if i == 0 {
                    day.leadingAnchor.constraint(equalTo: dayLabels[0].leadingAnchor).isActive = true
                }
                else {
                    day.leadingAnchor.constraint(equalTo: days[i-1].trailingAnchor, constant: margin).isActive = true
                }
            }
            else {
                day.topAnchor.constraint(equalTo: days[i-7].bottomAnchor, constant: 3).isActive = true
                day.leadingAnchor.constraint(equalTo: days[i-7].leadingAnchor).isActive = true
                day.trailingAnchor.constraint(equalTo: days[i-7].trailingAnchor).isActive = true
                day.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
            
            i+=1
        }
        
    }
    
    
    func genNumDays(month: Int, year: Int) -> Int {
        let days = [
            1: 31,
            2: 28,
            3: 31,
            4: 30,
            5: 31,
            6: 30,
            7: 31,
            8: 31,
            9: 30,
            10: 31,
            11: 30,
            12: 31
        ]
        
        if month == 2 {
            if year % 2020 == 0 {
                return 29
            }
        }
        return days[month]!
    }
    
    
    func genFirstWeekDay(startDate: Date) -> Int {
        let dayOfWeek = calendar.component(.weekday, from: startDate)
        let correctionFactor = (calendar.component(.day, from: startDate)-1) % 7
        if correctionFactor >= dayOfWeek {
            return 7 - correctionFactor + dayOfWeek
        }
        return dayOfWeek - correctionFactor
    }
    
    @objc func selectDay(_ sender: DayButton){
        if let _ = sender.date {
            if let lastDate = selectedButton {
                lastDate.backgroundColor = .white
                lastDate.setTitleColor(UIColor.black.withAlphaComponent(0.7), for: .normal)
            }
            let ds = "\(year!)-\(month!)-\(sender.day!)"
            dateformatter.dateFormat = "yyyy-MM-dd"
            selectedDay = dateformatter.date(from: ds)!
            selectedButton = sender
            sender.backgroundColor = style.backgroundColors[color]
            sender.setTitleColor(style.textColors[color], for: .normal)
        }
        
    }
    
    @objc func nextMonth(_ sender: UIButton) {
        let newDate = calendar.date(byAdding: .day, value: 1, to: lastDate!)!
        self.updateData(seedDate: newDate)
    }
    
    @objc func prevMonth(_ sender: UIButton) {
        let newDate = calendar.date(byAdding: .day, value: -1, to: firstDate!)!
        self.updateData(seedDate: newDate)
    }

}

class DayButton: UIButton {
    var day: Int?
    var date: Date?
}

