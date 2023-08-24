//
//  Date+Extension.swift
//  ybs-interview
//
//  Created by Lenard Pop on 27/08/2023.
//

import Foundation

extension Date {
    func fromString(value: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: value) {
            return date
        } else {
            print("Unable to convert the string to a date.")
            return nil
        }
    }

    ///  It will be re-formatting the current date into a more friendly one
    ///  which will help understand it better
    ///  ```swift
    ///  `d'th' MMMM yyyy`
    ///  8th February 2023
    ///  ```
    func toFriendlyDateLong() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d'\(self.daySuffix())' MMMM yyyy"
        formatter.timeZone = TimeZone(identifier: "Europe/London")

        return formatter.string(from: self)
    }

    ///  It will be re-formatting the current date into a more friendly one
    ///  which will help understand it better
    ///  ```swift
    ///  `d'th' MMM yy`
    ///  8th Feb 23
    ///  ```
    func toFriendlyDateShort() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d'\(self.daySuffix())' MMM yy"
        formatter.timeZone = TimeZone(identifier: "Europe/London")

        return formatter.string(from: self)
    }

    private func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}
