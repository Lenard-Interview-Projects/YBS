//
//  PhotoModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

import Foundation

public struct PhotoModel: Codable {
    public let id: String
    public let secret: String
    public let server: String
    public let farm: Int
    public let views: String
    public let owner: PhotoOwnerModel
    public let dates: PhotoDatesModel
    public let tags: PhotoTagsModel
    private let title: ContentStringModel
    private let description: ContentStringModel
    private let comments: ContentStringModel

    public func getPhotoUrl() -> String {
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }

    public var getTitle: String {
        return title._content
    }

    public var getDescription: String {
        return description._content
    }

    public var getCommentsCount: String {
        return comments._content
    }

    public var getTakenDate: Date {
        return dates.taken.toDate() ?? Date()
    }

    public init() {
        self.id = ""
        self.secret = ""
        self.server = ""
        self.farm = 0
        self.views = ""
        self.owner = PhotoOwnerModel()
        self.title = ContentStringModel()
        self.description = ContentStringModel()
        self.comments = ContentStringModel()
        self.dates = PhotoDatesModel()
        self.tags = PhotoTagsModel()
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case owner = "owner"
        case title = "title"
        case description = "description"
        case comments = "comments"
        case dates = "dates"
        case views = "views"
        case tags = "tags"
    }
}
