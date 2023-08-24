//
//  URLProvider.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

import Foundation

internal class URLProvider: URLProviderProtocol {

    /// Search
    public func getRecentPhotosURL(page: Int = 1) -> String {
        return "\(Config.baseUrl)&\(FlickrMethod.Recent.rawValue)&\(FlickrParameters.Page.toString(value: String(describing: page)))"
    }

    public func getSearchQueryPhotosURL(query: String = "", tagMode: FlickrTagMode = .Some, page: Int? = nil) -> String {
        var url = "\(Config.baseUrl)&\(FlickrMethod.Search.rawValue)"

        if !query.isEmpty {
            if query.toListOfTags().isEmpty {
                url += "&\(FlickrParameters.Text.toString(value: query))"
            } else {
                url += "&\(FlickrParameters.Tags.toString(value: query))"
                url += "&\(FlickrParameters.TagMode.toString(value: tagMode.rawValue))"
            }
        }

        if page != nil { url += "&\(FlickrParameters.Page.toString(value: String(page ?? 0)))" }

        return url
    }

    /// Photo
    public func getPhotoInfoURL(photoId: String) -> String {
        var url = "\(Config.baseUrl)&\(FlickrMethod.PhotoInfo.rawValue)"
        url += "&\(FlickrParameters.PhotoId.toString(value: photoId))"

        return url
    }

    /// User
    public func getUserInfoURL(userId: String) -> String {
        var url = "\(Config.baseUrl)&\(FlickrMethod.UserInfo.rawValue)"
        url += "&\(FlickrParameters.UserId.toString(value: userId))"

        return url
    }

    public func getUserPhotosURL(userId: String, perPage: Int = 20, page: Int = 1) -> String {
        var url = "\(Config.baseUrl)&\(FlickrMethod.UserPhotos.rawValue)"
        url += "&\(FlickrParameters.UserId.toString(value: userId))"
        url += "&\(FlickrParameters.Page.toString(value: String(page)))"
        url += "&\(FlickrParameters.PerPage.toString(value: String(perPage)))"

        return url
    }
}
