//
//  UserPhotosStatsModel.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

import Foundation

public struct UserPhotosStatsModel: Codable {
    private let firstdatetaken: ContentStringModel?
    private let firstdate: ContentStringModel?
    private let count: ContentIntModel?

    public var getFirstPhotoDate: Date {
        return firstdatetaken?._content.toDate() ?? Date()
    }

    public var getFirstDate: String {
        return firstdate?._content ?? ""
    }

    public var getCount: Int {
        return count?._content ?? 0
    }

    public init() {
        firstdatetaken = ContentStringModel()
        firstdate = ContentStringModel()
        count = ContentIntModel()
    }

    enum CodingKeys: String, CodingKey {
        case firstdatetaken = "firstdatetaken"
        case firstdate = "firstdate"
        case count = "count"
    }
}
