//
//  SearchResponseModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 24/08/2023.
//


public struct SearchResponseModel: Codable {
    public let photos: SearchPhotosModel
    public let stat: String

    public init() {
        photos = SearchPhotosModel(page: 0, pages: 0, perpage: 0, total: 0, photo: [])
        stat = ""
    }

    enum CodingKeys: String, CodingKey {
        case photos = "photos"
        case stat = "stat"
    }
}
