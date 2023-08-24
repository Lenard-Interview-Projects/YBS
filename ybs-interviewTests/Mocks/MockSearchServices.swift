//
//  MockSearchServices.swift
//  ybs-interviewTests
//
//  Created by Lenard Pop on 28/08/2023.
//

import Foundation
import YBSServices
import Combine

public final class MockSearchServices: SearchServicesProtocol {
     private var searchResponseModel: SearchResponseModel?
    private var errorFound: Bool = false

    public init() { }

    public func withResult(searchResponseModel: SearchResponseModel) {
        self.searchResponseModel = searchResponseModel
    }

    public func withError() {
        errorFound = true
    }

    public func fetchRecentResults(page: Int) -> AnyPublisher<SearchResponseModel, Error> {
        let optionalPublisher = Just(searchResponseModel)

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

    public func fetchSearchResults(search query: String, tagMode: FlickrTagMode, page: Int?) -> AnyPublisher<SearchResponseModel, Error> {
        let optionalPublisher = Just(searchResponseModel)

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
