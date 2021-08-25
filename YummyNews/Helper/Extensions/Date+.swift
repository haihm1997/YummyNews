//
//  DateUtil.swift
//  VNShop
//
//  Created by linhvt on 9/16/19.
//  Copyright © 2019 Teko. All rights reserved.
//

import Foundation


public extension Date {
    
    enum StyleDate: String {
        case serverFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }

    func toString(formatter: Date.StyleDate) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = formatter.rawValue
        let dateString = dateFormatter.string(from: self)
        dateFormatter.locale = Locale.init(identifier: "en")
        return dateString
    }
    
}

public extension Date {

    func isInToday(inCalendar calendar: Calendar = .current) -> Bool {
        return calendar.isDateInToday(self)
    }

    func isInYesterday(inCalendar calendar: Calendar = .current) -> Bool {
        return calendar.isDateInYesterday(self)
    }

    func isInTomorrow(inCalendar calendar: Calendar = .current) -> Bool {
        return calendar.isDateInTomorrow(self)
    }

    func year(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.year], from: self).year
    }

    func month(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.month], from: self).month
    }

    func day(calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([.day], from: self).day
    }
    
    func getNumberOfDay() -> Int? {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day
    }
    
    func getNumberOfMonth() -> Int? {
        return Calendar.current.dateComponents([.month], from: self, to: Date()).month
    }
    
    func isInSameDay(inCalendar calendar: Calendar = .current) -> Bool {
        let day1 = self
        let day2 = self
        let sameYear = day1.year(calendar: calendar) == day2.year(calendar: calendar)
        let sameMonth = day1.month(calendar: calendar) == day2.month(calendar: calendar)
        let sameDay = day1.day(calendar: calendar) == day2.day(calendar: calendar)
        return sameYear && sameMonth && sameDay
    }

    func date(byAdding component: Calendar.Component, value: Int, inCalendar calendar: Calendar = .current) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self)
    }

    func truncated(calendar: Calendar = .current) -> Date {
        let comp = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: comp) ?? self
    }

    func firstDayOfMonth(calendar: Calendar = .current) -> Date? {
        var cal = calendar
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        var components = cal.dateComponents([.year, .month, .day], from: self)
        guard let range = cal.range(of: .day, in: .month, for: self) else { return nil }
        components.day = range.lowerBound
        return cal.date(from: components)
    }

    func lastDayOfMonth(calendar: Calendar = .current) -> Date? {
        var cal = calendar
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        var components = cal.dateComponents([.year, .month, .day], from: self)
        guard let range = cal.range(of: .day, in: .month, for: self) else { return nil }
        components.day = range.upperBound - 1
        return cal.date(from: components)
    }

    func mediumDateString(locale: Locale = .current, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.timeZone = timeZone
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: self)
    }
    
    func toTimeAgoString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    }
}

