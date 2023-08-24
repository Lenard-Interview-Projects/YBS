//
//  MockPhotoServices.swift
//  ybs-interviewTests
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation
import YBSServices
import Combine

public final class MockPhotoServices: PhotoServicesProtocol {
    private var photoResponseModel: PhotoResponseModel?
    private var errorFound: Bool = false

    public init() { }

    public func withResult(photoResponseModel: PhotoResponseModel) {
        self.photoResponseModel = photoResponseModel
    }

    public func withError() {
        errorFound = true
    }

    public func fetchPhotoInfo(photoId: String) -> AnyPublisher<PhotoResponseModel, Error> {
        let optionalPublisher = Just(photoResponseModel)

        return optionalPublisher
            .flatMap { (data: PhotoResponseModel?) -> AnyPublisher<PhotoResponseModel, Error> in
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
