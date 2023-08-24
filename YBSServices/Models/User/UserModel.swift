//
//  UserModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 25/08/2023.
//

public struct UserModel: Codable {
    public let id: String
    public let nsid: String
    public let ispro: Int
    public let iconserver: String
    public let iconfarm: Int
    public let photos: UserPhotosStatsModel
    private let username: ContentStringModel?
    private let realname: ContentStringModel?
    private let location: ContentStringModel?

    public var getUsername: String {
        return username?._content ?? ""
    }

    public var getRealname: String {
        return realname?._content ?? ""
    }

    public var getLocation: String {
        return location?._content ?? ""
    }

    public var getUserAvatar: String {
        return "https://farm\(iconfarm).staticflickr.com/\(iconserver)/buddyicons/\(nsid)_l.jpg"
    }

    public init() {
        id = ""
        nsid = ""
        ispro = 0
        iconserver = ""
        iconfarm = 0
        username = ContentStringModel()
        realname = ContentStringModel()
        location = ContentStringModel()
        photos = UserPhotosStatsModel()
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nsid = "nsid"
        case ispro = "ispro"
        case iconserver = "iconserver"
        case iconfarm = "iconfarm"
        case photos = "photos"
        case location = "location"
        case username = "username"
        case realname = "realname"
    }
}
