//
//  PhotoResponseModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

public struct PhotoResponseModel: Codable {
    public let photo: PhotoModel
    public let stat: String

    public init() {
        self.photo = PhotoModel()
        self.stat = ""
    }

    enum CodingKeys: String, CodingKey {
        case photo = "photo"
        case stat = "stat"
    }
}
