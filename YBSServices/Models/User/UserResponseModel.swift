//
//  UserResponseModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 25/08/2023.
//

import Foundation

public struct UserResponseModel: Codable {
    public let person: UserModel
    public let stat: String

    public init() {
        person = UserModel()
        stat = ""
    }

    enum CodingKeys: String, CodingKey {
        case person = "person"
        case stat = "stat"
    }
}
