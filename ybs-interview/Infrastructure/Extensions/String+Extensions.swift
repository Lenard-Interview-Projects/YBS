//
//  String+Extensions.swift
//  ybs-interview
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("Unable to convert the string to a date.")
            return nil
        }
    }
}
