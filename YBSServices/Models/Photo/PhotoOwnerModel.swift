//
//  PhotoOwnerModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

public struct PhotoOwnerModel: Codable {
    public let nsid: String
    public let username: String
    public let realname: String
    public let iconserver: String
    public let iconfarm: Int

    public init() {
        self.nsid = ""
        self.username = ""
        self.realname = ""
        self.iconserver = ""
        self.iconfarm = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case nsid = "nsid"
        case username = "username"
        case realname = "realname"
        case iconserver = "iconserver"
        case iconfarm = "iconfarm"
    }
}
