//
//  DateExtensionTests.swift
//  ybs-interviewTests
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation
import XCTest
@testable import ybs_interview

class DateExtensionTests: XCTestCase {
    func test_toFriendlyDate_short() throws {
        // Arrange
        var data = [(date: Date, expected: String)]()
        data.append(("2023-01-01 01:28:33".toDate()!, expected: "1st Jan 23"))
        data.append(("2023-12-31 01:28:33".toDate()!, expected: "31st Dec 23"))

        data.forEach { testCase in
            // Act
            let result = testCase.date.toFriendlyDateShort()

            // Assert
            XCTAssertEqual(testCase.expected, result)
        }
    }

    func test_toFriendlyDate_long() throws {
        // Arrange
        var data = [(date: Date, expected: String)]()
        data.append(("2023-01-01 01:28:33".toDate()!, expected: "1st January 2023"))
        data.append(("2023-12-31 01:28:33".toDate()!, expected: "31st December 2023"))

        data.forEach { testCase in
            // Act
            let result = testCase.date.toFriendlyDateLong()

            // Assert
            XCTAssertEqual(testCase.expected, result)
        }
    }

    func test_toDateConversion_valid() throws {
        // Arrange
        let dateString = "2023-08-24 08:31:14"
        let dateToVerifyAgainst = Date(year: 2023, month: 8, day: 24, hour: 8, minute: 31, second: 14)

        // Act
        let convertedToDate = dateString.toDate()

        // Assert
        XCTAssertEqual(dateToVerifyAgainst, convertedToDate)
    }

    func test_toDateConversion_inValid() throws {
        // Arrange
        let dateString = "2023-08-24-31:14"
        let dateToVerifyAgainst = Date(year: 2023, month: 8, day: 24, hour: 8, minute: 31, second: 14)

        // Act
        let convertedToDate = dateString.toDate()

        // Assert
        XCTAssertNil(convertedToDate)
    }
}
