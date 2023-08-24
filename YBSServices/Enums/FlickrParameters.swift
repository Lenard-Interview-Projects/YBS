//
//  FlickrParameters.swift
//  YBSServices
//
//  Created by Lenard Pop on 25/08/2023.
//

internal enum FlickrParameters {
    case Text
    case Tags
    case UserId
    case PhotoId
    case PerPage
    case Page
    case Sort
    case TagMode

    func toString(value: String) -> String {
        switch (self) {
        case .Tags:
            return "tags=\(value)"
        case .TagMode:
            return "tag_mode=\(value)"
        case .Text:
            return "text=\(value)"
        case .UserId:
            return "user_id=\(value)"
        case .PhotoId:
            return "photo_id=\(value)"
        case .PerPage:
            return "per_page=\(value)"
        case .Page:
            return "page=\(value)"
        case .Sort:
            return "sort=\(value)"
        }
    }
}
