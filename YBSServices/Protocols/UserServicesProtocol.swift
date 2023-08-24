//
//  UserServiceProtocol.swift
//  YBSServices
//
//  Created by Lenard Pop on 25/08/2023.
//

import Foundation
import Combine

public protocol UserServicesProtocol {
    func getUserInfo(userId: String) -> AnyPublisher<UserResponseModel, Error>
    func getUserPhotos(userId: String, perPage: Int, page: Int) -> AnyPublisher<SearchResponseModel, Error>
}
