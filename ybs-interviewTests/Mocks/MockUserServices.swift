//
//  MockUserServices.swift
//  ybs-interviewTests
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation
import YBSServices
import Combine

public final class MockUserServices: UserServicesProtocol {
    private var userResponseModel: UserResponseModel?
    private var userPhotosResponseModel: SearchResponseModel?
    private var errorFound: Bool = false

    public init() { }

    public func withResult(userResponseModel: UserResponseModel) {
        self.userResponseModel = userResponseModel
    }

    public func withResult(userPhotosResponseModel: SearchResponseModel) {
        self.userPhotosResponseModel = userPhotosResponseModel
    }

    public func withError() {
        errorFound = true
    }

    public func getUserInfo(userId: String) -> AnyPublisher<UserResponseModel, Error> {
        let optionalPublisher = Just(userResponseModel)

        return optionalPublisher
            .flatMap { (data: UserResponseModel?) -> AnyPublisher<UserResponseModel, Error> in
                if let data = data, self.errorFound == false {
                    return Just(data)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    let error = NSError(domain: "YourErrorDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Value is nil"])
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    public func getUserPhotos(userId: String, perPage: Int, page: Int) -> AnyPublisher<YBSServices.SearchResponseModel, Error> {
        let optionalPublisher = Just(userPhotosResponseModel)

        return optionalPublisher
            .flatMap { (data: SearchResponseModel?) -> AnyPublisher<SearchResponseModel, Error> in
                if let data = data, self.errorFound == false {
                    return Just(data)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    let error = NSError(domain: "YourErrorDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Value is nil"])
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
