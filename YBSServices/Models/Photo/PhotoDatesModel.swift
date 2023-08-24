//
//  PhotoDatesModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

public struct PhotoDatesModel: Codable {
    public let posted: String
    public let taken: String

    public init() {
        self.posted = ""
        self.taken = ""
    }

    enum CodingKeys: String, CodingKey {
        case posted = "posted"
        case taken = "taken"
    }
}
