//
//  SearchViewModelTests.swift
//  ybs-interviewTests
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation
import YBSServices
import XCTest
@testable import ybs_interview

class SearchViewModelTests: XCTestCase {
    var searchService: MockSearchServices!
    var viewModel: SearchViewModel!

    override func setUp() {
        self.searchService = MockSearchServices()
        self.viewModel = SearchViewModel(searchServices: searchService)
    }

    func test_initial_values() throws {
        // Arrange
        // Act
        // Assert
        XCTAssertEqual(0, viewModel.images.count)
        XCTAssertEqual("", viewModel.searchQuery)
        XCTAssertEqual(SearchOrderBy.Relevance, viewModel.selectedOrderBy)

        XCTAssertTrue(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isInitialized)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingRecentResults_valid() throws {
        // Arrange
        let searchResponse: SearchResponseModel? = TestUtil.shared.convertJSONtoObject(fileName: "RecentResponseModelData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not read contents of file")
            return
        }

        searchService.withResult(searchResponseModel: searchResponse)

        // Act
        viewModel.fetchRecentResults()

        // Assert
        XCTAssertEqual(10, viewModel.images.count)

        XCTAssertEqual(["53145680957", "53145681242", "53145681582", "53146265086","53146472199","53146472484","53146689520","53146758103","53146758378", "53146758673"], viewModel.images.map({ $0.id }))

        XCTAssertTrue(viewModel.isInitialized)
        XCTAssertTrue(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingRecentResults_errorFound() throws {
        // Arrange
        searchService.withError()

        // Act
        viewModel.fetchRecentResults()

        // Assert
        XCTAssertEqual(0, viewModel.images.count)

        XCTAssertTrue(viewModel.errorFound)
        XCTAssertTrue(viewModel.isInitialized)

        XCTAssertFalse(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
    }

    func test_fetchingSearchResults_valid() throws {
        // Arrange
        let expectation = XCTestExpectation(description: "Debounce Delay")

        let searchResponse: SearchResponseModel? = TestUtil.shared.convertJSONtoObject(fileName: "SearchResponseModelData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not read contents of file")
            return
        }

        searchService.withResult(searchResponseModel: searchResponse)

        viewModel.searchQuery = "cats"

        // Act
        viewModel.searchQueryListener()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 2)

        XCTAssertEqual(7, viewModel.images.count)
        XCTAssertEqual(["53146740938", "53146615853", "53146600563", "53146086151", "53146161269", "53146358528", "53146076939"], viewModel.images.map({ $0.id }))

        XCTAssertTrue(viewModel.isInitialized)
        XCTAssertTrue(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingSearchResults_errorFound() throws {
        // Arrange
        let expectation = XCTestExpectation(description: "Debounce Delay")

        searchService.withError()
        viewModel.searchQuery = "cats"

        // Act
        viewModel.searchQueryListener()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 2)

        XCTAssertEqual(0, viewModel.images.count)

        XCTAssertTrue(viewModel.errorFound)
        XCTAssertTrue(viewModel.isInitialized)

        XCTAssertFalse(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
    }
}
