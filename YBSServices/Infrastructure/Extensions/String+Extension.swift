//
//  UnicodeEscape.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

import Foundation

extension String {
    public func toUnicodeEscapeSequences() -> String {
        let pattern = "\\\\u([0-9a-fA-F]{4})"
        let regex = try! NSRegularExpression(pattern: pattern)

        let modifiedText = regex.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(self.startIndex..<self.endIndex, in: self),
            withTemplate: "\\\\u{$1}"
        )

        return modifiedText
    }
    
    public func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current

        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("Unable to convert the string to a date.")
            return nil
        }
    }

    public func toListOfTags() -> [String] {
        if !self.contains(",") { return [] }

        return self
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
    }
}
