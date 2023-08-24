//
//  UserProfileViewModelTests.swift
//  ybs-interviewTests
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation
import YBSServices
import XCTest
@testable import ybs_interview

class UserProfileViewModelTests: XCTestCase {
    var userServices: MockUserServices!
    var viewModel: UserProfileViewModel!

    override func setUp() {
        self.userServices = MockUserServices()
        self.viewModel = UserProfileViewModel(userId: "53139302418", userServices: userServices)
    }

    func test_initial_values() throws {
        // Arrange
        // Act
        // Assert
        XCTAssertEqual("", viewModel.user.id)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isInitialized)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertTrue(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingUserDetailsResults_valid() throws {
        // Arrange
        let userResponseModel: UserResponseModel? = TestUtil.shared.convertJSONtoObject(fileName: "UserInfoResponseModelData")
        let userPhotosResponseModel: SearchResponseModel? = TestUtil.shared.convertJSONtoObject(fileName: "UserPhotosResponseModelData")

        guard let userResponseModel = userResponseModel, let userPhotosResponseModel = userPhotosResponseModel else {
            XCTFail("Could not read contents of file")
            return
        }

        userServices.withResult(userResponseModel: userResponseModel)
        userServices.withResult(userPhotosResponseModel: userPhotosResponseModel)

        // Act
        viewModel.fetchUserDetails()

        // Assert
        XCTAssertEqual("197340444@N07", viewModel.user.id)
        XCTAssertEqual("197340444@N07", viewModel.user.nsid)
        XCTAssertEqual("65535", viewModel.user.iconserver)
        XCTAssertEqual("", viewModel.user.getLocation)
        XCTAssertEqual("Miyoko Katō", viewModel.user.getRealname)
        XCTAssertEqual("https://farm66.staticflickr.com/65535/buddyicons/197340444@N07_l.jpg", viewModel.user.getUserAvatar)
        XCTAssertEqual("vintagebunnyx3", viewModel.user.getUsername)

        XCTAssertEqual(66, viewModel.user.iconfarm)
        XCTAssertEqual(0, viewModel.user.ispro)
        XCTAssertEqual(139, viewModel.user.photos.getCount)

        XCTAssertEqual(Date(year: 2023, month: 1, day: 24, hour: 1, minute: 28, second: 33), viewModel.user.photos.getFirstPhotoDate)

        XCTAssertEqual(["53143824974", "53144100913", "53143027092", "53143824384","53143824374","53143615631","53140213971","53139619237","53137284111", "53136686267"], viewModel.gallery.map({ $0.id }))

        XCTAssertTrue(viewModel.isInitialized)
        XCTAssertTrue(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingUserDetailsResults_errorFound() throws {
        // Arrange
        userServices.withError()

        // Act
        viewModel.fetchUserDetails()

        // Assert
        XCTAssertEqual("", viewModel.user.id)
        XCTAssertTrue(viewModel.gallery.isEmpty)

        XCTAssertTrue(viewModel.errorFound)
        XCTAssertTrue(viewModel.isInitialized)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.canLoadMore)
    }
}
