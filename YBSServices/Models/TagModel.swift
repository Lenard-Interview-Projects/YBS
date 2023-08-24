//
//  TagModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

public struct TagModel: Codable {
    public let id: String
    public let author: String
    public let raw: String
    public let _content: String

    public init() {
        self.id = ""
        self.author = ""
        self.raw = ""
        self._content = ""
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case raw = "raw"
        case _content = "_content"
    }
}
