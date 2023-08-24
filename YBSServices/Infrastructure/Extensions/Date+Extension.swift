//
//  Date+Extension.swift
//  YBSServices
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation

extension Date {
    public init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone.current

        let date = calendar.date(from: DateComponents(
                                    calendar: calendar,
                                    year: year,
                                    month: month,
                                    day: day,
                                    hour: hour,
                                    minute: minute,
                                    second: second))!
        self.init(timeInterval: 0, since: date)
    }
}
