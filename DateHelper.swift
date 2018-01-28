//
//  DateHelper.swift
//  NotesTestTask
//
//  Created by Bogdan Koshyrets on 9/23/17.
//  Copyright © 2017 Bohdan Koshyrets. All rights reserved.
//

import Foundation

struct DateHelper {
    static func dayModified(_ date: Date) -> String {
        if date.isInFuture      { return "Unknown" }
        if date.isInToday       { return date.timeString(ofStyle: .short) }
        if date.isInYesterday   { return "Yesterday" }
        if date.isInThisWeek    { return date.dayName(ofStyle: .full) }
        return date.dateString()
    }
    
    static func dateFromTodayByAdding(day: Int) -> Date {
        let date = Date()
        var dayComponent = DateComponents()
        dayComponent.day = day
        return date.calendar.date(byAdding: dayComponent, to: date)!
    }
}
