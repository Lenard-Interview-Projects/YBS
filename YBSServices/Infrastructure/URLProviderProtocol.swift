//
//  URLProviderProtocol.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

import Foundation

internal protocol URLProviderProtocol {

    /// Search
    func getRecentPhotosURL(page: Int) -> String
    func getSearchQueryPhotosURL(query: String, tagMode: FlickrTagMode, page: Int?) -> String

    /// Photo
    func getPhotoInfoURL(photoId: String) -> String

    /// User
    func getUserInfoURL(userId: String) -> String
    func getUserPhotosURL(userId: String, perPage: Int, page: Int) -> String
}
