//
//  PhotoTagsModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

public struct PhotoTagsModel: Codable {
    public let tag: [TagModel]

    public init() {
        self.tag = []
    }

    enum CodingKeys: String, CodingKey {
        case tag = "tag"
    }
}
