//
//  SearchPhotosModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 24/08/2023.
//

public struct SearchPhotosModel: Codable {
    public let page: Int
    public let pages: Int
    public let perpage: Int
    public let total: Int
    public let photo: [SearchPhotoModel]

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case total = "total"
        case photo = "photo"
    }
}
