//
//  UserServiceProtocol.swift
//  YBSServices
//
//  Created by Lenard Pop on 25/08/2023.
//

import Foundation
import Combine

public protocol UserServicesProtocol {
    func getUserInfo(userId: String) -> AnyPublisher<UserResponseModel, Never>
    func getUserPhotos(userId: String) -> AnyPublisher<SearchResponseModel, Never>
}
