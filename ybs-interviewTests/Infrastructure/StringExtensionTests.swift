//
//  StringExtensionTests.swift
//  ybs-interviewTests
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation
import YBSServices
import XCTest

class StringExtensionTests: XCTestCase {

    func test_toDate_valid() throws {
        // Arrange
        let stringDate = "2023-08-24 09:31:14"

        // Act
        let dateString = stringDate.toDate() ?? Date()

        // Assert
        XCTAssertEqual(Date(year: 2023, month: 8, day: 24, hour: 9, minute: 31, second: 14), dateString)
    }

    func test_toDate_failed() throws {
        // Arrange
        let stringDate = "2023-08-24T09:31:14"

        // Act
        let dateString = stringDate.toDate() ?? Date()

        // Assert
        XCTAssertNotEqual(Date(year: 2023, month: 8, day: 24, hour: 9, minute: 31, second: 14), dateString)
    }

    func test_containsImageTags_valid() throws {
        // Arrange
        let tags = "cats,cat, dog, dogs"

        // Act
        let tagsList = tags.toListOfTags()

        // Assert
        XCTAssertEqual(["cats", "cat", "dog", "dogs"], tagsList)
    }
    
    func test_containsImageTags_failed() throws {
        // Arrange
        let tags = "cats"

        // Act
        let tagsList = tags.toListOfTags()

        // Assert
        XCTAssertEqual([], tagsList)
    }
}
