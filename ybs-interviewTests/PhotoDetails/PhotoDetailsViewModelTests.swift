//
//  PhotoDetailsViewModelTests.swift
//  ybs-interviewTests
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation
import YBSServices
import XCTest
@testable import ybs_interview

class PhotoDetailsViewModelTests: XCTestCase {
    var photoServices: MockPhotoServices!
    var viewModel: PhotoDetailsViewModel!

    override func setUp() {
        self.photoServices = MockPhotoServices()
        self.viewModel = PhotoDetailsViewModel(photoId: "53139302418", photoServices: photoServices)
    }

    func test_initial_values() throws {
        // Arrange
        // Act
        // Assert
        XCTAssertEqual("", viewModel.photo.id)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isInitialized)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingPhotoInfoResults_valid() throws {
        // Arrange
        let photoResponseModel: PhotoResponseModel? = TestUtil.shared.convertJSONtoObject(fileName: "PhotoInfoResponseModelData")

        guard let photoResponseModel = photoResponseModel else {
            XCTFail("Could not read contents of file")
            return
        }

        photoServices.withResult(photoResponseModel: photoResponseModel)

        // Act
        viewModel.fetchPhotoDetails()

        // Assert
        XCTAssertEqual("53139302418", viewModel.photo.id)
        XCTAssertEqual("9de03c12f7", viewModel.photo.secret)
        XCTAssertEqual("65535", viewModel.photo.server)
        XCTAssertEqual(66, viewModel.photo.farm)
        XCTAssertEqual("21", viewModel.photo.views)
        XCTAssertEqual("0", viewModel.photo.getCommentsCount)
        XCTAssertEqual("via \nVới thiết kế 3 buồng tiện ích, mẫu tủ quần áo 3", viewModel.photo.getDescription)
        XCTAssertEqual("Mẫu tủ quần áo 3 buồng hiện đại", viewModel.photo.getTitle)
        XCTAssertEqual(Date(year: 2023, month: 8, day: 24, hour: 9, minute: 31, second: 14), viewModel.photo.getTakenDate)

        XCTAssertTrue(viewModel.isInitialized)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingPhotoInfoResults_errorFound() throws {
        // Arrange
        photoServices.withError()

        // Act
        viewModel.fetchPhotoDetails()

        // Assert
        XCTAssertEqual("", viewModel.photo.id)

        XCTAssertTrue(viewModel.errorFound)
        XCTAssertTrue(viewModel.isInitialized)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
    }
}
