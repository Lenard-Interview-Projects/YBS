//
//  SearchPhotoModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 24/08/2023.
//

public struct SearchPhotoModel: Codable {
    public let id: String
    public let owner: String
    public let secret: String
    public let server: String
    public let farm: Int
    public let title: String
    public let ispublic: Int
    public let isfriend: Int
    public let isfamily: Int

    public func getPhotoUrl() -> String {
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }

    public init() {
        id = ""
        owner = ""
        secret = ""
        server = ""
        farm = 0
        title = ""
        ispublic = 0
        isfriend = 0
        isfamily = 0
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
        case ispublic = "ispublic"
        case isfriend = "isfriend"
        case isfamily = "isfamily"
    }
}
