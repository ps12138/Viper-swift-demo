//
//  Calendar+Additions.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//



import Foundation

extension Calendar {
    
    /// Create a gregorian Calendar
    ///
    /// - Returns: Calendar with .gregorian
    static func gregorianCalendar() -> Calendar {
        return Calendar(identifier: .gregorian)
    }
    
    
    /// Create date
    ///
    /// - Parameters:
    ///   - year: year
    ///   - month: month
    ///   - day: day
    /// - Returns: Date?
    func date(year: Int, month: Int, day: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 24
        return components.date
    }
    
    
    /// Calculate tomorrow
    ///
    /// - Parameter today: today date
    /// - Returns: tomorrpw
    func date(tomorrowOfToday today: Date) -> Date {
        var tomorrowComponents = DateComponents()
        tomorrowComponents.day = 1
        return date(byAdding: tomorrowComponents, to: today)!
    }
    
    
    
    /// Calculate end of week based on today
    ///
    /// - Parameter today: today
    /// - Returns: end of week based on today
    func date(endOfWeekWithDate today: Date) -> Date {
        let daysRemainingThisWeek = days(remainingInWeekFrom: today)
        var remainingDaysComponent = DateComponents()
        remainingDaysComponent.day = daysRemainingThisWeek
    
        return date(byAdding: remainingDaysComponent, to: today)!
    }
    
    
    /// Calculate begin of day
    ///
    /// - Parameter today: today
    /// - Returns: begin of today with 00:00
    func date(beginningOfDate today: Date) -> Date {
        let newComponent = dateComponents([.year, .month, .day], from: today)
        let newDate = date(from: newComponent)
        return newDate!
    }
    
    
    
    /// Calculate end of day
    ///
    /// - Parameter today: today date
    /// - Returns: end of today with 00:00
    func date(endOfDate today: Date) -> Date {
        var components = DateComponents()
        components.day = 1
        let toDate = date(beginningOfDate: today)
        let nextDay = date(byAdding: components, to: toDate)
        let endDay = nextDay?.addingTimeInterval(-1)
        return endDay!
        
    }
    
    
    
    /// Calculate days remaining
    ///
    /// - Parameter date: today's date
    /// - Returns: rest days within week
    func days(remainingInWeekFrom today: Date) -> Int {
        let weekdayComponent = component(.weekday, from: today)
        if let dayRange = range(of: .weekday, in: .weekday, for: today) {
            let daysPerWeek = dayRange.upperBound - dayRange.lowerBound
            let daysRemaining = daysPerWeek - weekdayComponent
            return daysRemaining
        }
        return 0
    }
    
    /// Calculate next week end date from today
    ///
    /// - Parameter today: today
    /// - Returns: next week end date
    func date(endOfFollowingWeekFrom today: Date) -> Date {
        let endOfWeek = date(endOfWeekWithDate: today)
        var nextWeekComponent = DateComponents()
        nextWeekComponent.setValue(1, for: .weekOfYear)
        let followingWeekDate = date(byAdding: nextWeekComponent, to: endOfWeek)
        return followingWeekDate!
    }
    
    /// Only consider YY:MM:DD, leftDate < rightDate
    ///
    /// - Parameters:
    ///   - leftDate: leftDate
    ///   - rightDate: leftDate
    /// - Returns: True: leftDate is prev, False: leftDate is not prev
    func isDate(_ leftDate: Date, before rightDate: Date) -> Bool {
        let comparison = compare(sameDay: leftDate, with: rightDate)
        let result = comparison == ComparisonResult.orderedAscending
        return result
    }
    
    /// Only consider YY:MM:DD, leftDate == rightDate
    ///
    /// - Parameters:
    ///   - leftDate: leftDate
    ///   - rightDate: rightDate
    /// - Returns: True: Equal,  False: notEqual
    func isDate(_ leftDate: Date, equalTo rightDate: Date) -> Bool {
        let comparison = compare(sameDay: leftDate, with: rightDate)
        let result = comparison == ComparisonResult.orderedSame
        return result
    }

    ///  within the same week
    ///
    /// - Parameters:
    ///   - leftDate: leftDate
    ///   - rightDate: rightDate
    /// - Returns: True: same week, Flase: diff week
    func isDate(_ leftDate: Date, duringSameWeek rightDate: Date) -> Bool {
        let leftWeekComponent = component(.weekOfYear, from: leftDate)
        let rightWeekComponent = component(.weekOfYear, from: rightDate)
        return leftWeekComponent == rightWeekComponent
    }
    
    /// leftDate is within next week of rightDate
    ///
    /// - Parameters:
    ///   - leftDate: leftDate
    ///   - rightDate: rightDate
    /// - Returns: True: in next week, Flase: not in
    func isDate(_ leftDate: Date, duringWeekAfter rightDate: Date) -> Bool {
        let leftNextWeekEnd = date(endOfFollowingWeekFrom: rightDate)
        let leftNextWeekComponent = component(.weekOfYear, from: leftNextWeekEnd)
        let rightWeekComponent = component(.weekOfYear, from: rightDate)
        return  leftNextWeekComponent == rightWeekComponent
    }
    
    
    func isDate(_ leftDate: Date, duringSameMonth rightDate: Date) -> Bool {
        let leftWeekComponent = component(.month, from: leftDate)
        let rightWeekComponent = component(.month, from: rightDate)
        return leftWeekComponent == rightWeekComponent
    }

    
    /// Calculate date relations, from left to right
    ///
    /// - Parameters:
    ///   - leftDate: left date
    ///   - rightDate: right date
    /// - Returns: NerTermDateReplation
    func date(relationfrom leftDate: Date, relativeTo rightDate: Date) -> DateRelation {
        var relation = DateRelation.OutOfRange

        let rightTomorrow = date(tomorrowOfToday: rightDate)

        let isLeftDateBefore = isDate(leftDate, before: rightDate)
        let isLeftDateEqualTo = isDate(leftDate, equalTo: rightDate)
        let isleftDateEqualToRightTomorrow = isDate(leftDate, equalTo: rightTomorrow)
        let isLeftDateDuringSameWeek = isDate(leftDate, duringSameWeek: rightDate)
        let isLeftDateDuringNextWeek = isDate(leftDate, duringWeekAfter: rightDate)
        let isLeftDateDuringSameMonth = isDate(leftDate, duringSameMonth: rightDate)
        
        // left < right
        if isLeftDateBefore {
            relation = .OutOfRange
        // left == right
        } else if isLeftDateEqualTo {
            relation = DateRelation.Today
        // left == right + 1
        } else if isleftDateEqualToRightTomorrow {
            // left right within same week
            if isLeftDateDuringSameWeek {
                relation = .Tomorrow
            // left in right's next week
            } else {
                relation = .NextWeek
            }
        // left > right + 1, within same week
        } else if isLeftDateDuringSameWeek {
            relation = .LaterThisWeek
        // left > right + 1, with diff week
        } else if isLeftDateDuringNextWeek {
            if isLeftDateDuringSameMonth {
                relation = .NextWeek
            } else {
                relation = .OutOfRange
            }
        // left > right, in the same month
        } else if isLeftDateDuringSameMonth{
            relation = .LaterThisMonth
        }
        return relation
    }
    
    
    
    
    /// Compare the same day based on YY:MM:DD,
    ///
    /// - Parameters:
    ///   - leftDate: left date
    ///   - rightDate: right date
    /// - Returns: COmparisonResult
    func compare(sameDay leftDate: Date, with rightDate: Date) -> ComparisonResult {
        let leftDateComponents = fetch(YYMMDD: leftDate)
        let rightDateComponents = fetch(YYMMDD: rightDate)
        
        var res = ComparisonResult.orderedSame
        
        if let leftYear = leftDateComponents.year,
            let rightYear = rightDateComponents.year {
            res = compare(left: leftYear, right: rightYear)
            if res != .orderedSame {
                return res
            }
        }
        
        if let leftMonth = leftDateComponents.month,
            let rightMonth = rightDateComponents.month {
            res = compare(left: leftMonth, right: rightMonth)
            if res != .orderedSame {
                return res
            }
        }
        
        if let leftDay = leftDateComponents.day,
            let rightDay = rightDateComponents.day {
            res = compare(left: leftDay, right: rightDay)
        }
        return res
    }
    
    
    
    /// fetch year month day components
    ///
    /// - Parameter date: date
    /// - Returns: DateComponents with year month day
    private func fetch(YYMMDD date: Date) -> DateComponents {
        let newComponents = dateComponents([.year, .month, .day], from: date)
        return newComponents
    }

    
    /// Compare two element
    ///
    /// - Parameters:
    ///   - left: left element
    ///   - right: right element
    /// - Returns: ComparisonResult,
    private func compare<T: Comparable>(left: T, right: T) -> ComparisonResult {
        var result = ComparisonResult.orderedDescending

        if left == right {
            result = ComparisonResult.orderedSame
        } else if left < right {
            result = ComparisonResult.orderedAscending
        } else {
            result = ComparisonResult.orderedDescending
        }
        return result
    }
}
