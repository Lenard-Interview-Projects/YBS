//
//  UserService.swift
//  YBSServices
//
//  Created by Lenard Pop on 25/08/2023.
//

import Foundation
import Combine

public final class UserServices: UserServicesProtocol {
    private var networking: NetworkingProtocol = Networking()
    private var urlProvider: URLProviderProtocol = URLProvider()

    public init() { }

    internal convenience init(networking: NetworkingProtocol, urlProvider: URLProviderProtocol) {
        self.init()
        self.networking = networking
        self.urlProvider = urlProvider
    }

    public func getUserInfo(userId: String) -> AnyPublisher<UserResponseModel, Error> {
        return networking
            .fetchData(url: urlProvider.getUserInfoURL(userId: userId))
    }

    public func getUserPhotos(userId: String, perPage: Int = 20, page: Int = 1) -> AnyPublisher<SearchResponseModel, Error> {
        return networking
            .fetchData(url: urlProvider.getUserPhotosURL(userId: userId, perPage: perPage, page: page))
    }
}
