//
//  NSDateExtension.swift
//  ComparisonTextNorms
//
//  Created by 王延磊 on 2022/7/15.
//

import Foundation
extension Date {
    
    /// 获取当前月份第一天是周几
    /// - Returns: 周几
    func getFirstWeekInMonth() -> Int {
        var dateComponents = self.getDateComponents()
        dateComponents.day = 1
        let newMonthDate = Calendar.current.date(from: dateComponents)!
        let newDateComponents = newMonthDate.getDateComponents()
        let weekDay = newDateComponents.weekday! - 1
        
        if weekDay == 0 {
            return 7
        }
        return weekDay
    }
    
    /// 获取指定月份天数
    func getDayNumOfMouth() -> Int {
        return Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self)!.count
    }
    
    /// 获取年月日周几
    func getDateComponents() -> DateComponents {
        let dateComponents = Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekday], from: self)
        return dateComponents
    }
    
    /// 获取当前日期是周几
    func getWeek() -> Int {
        let weeks = self.getDateComponents().weekday! - 1
        if weeks == 0 {
            return 7
        }
        return weeks
    }
}
