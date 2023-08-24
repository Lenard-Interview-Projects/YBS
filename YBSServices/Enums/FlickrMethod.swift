//
//  FlickrMethod.swift
//  YBSServices
//
//  Created by Lenard Pop on 25/08/2023.
//

import Foundation

internal enum FlickrMethod: String {
    case Search = "method=flickr.photos.search"
    case Recent = "method=flickr.photos.getRecent"
    case UserInfo = "method=flickr.people.getInfo"
    case UserPhotos = "method=flickr.people.getPhotos"
    case PhotoInfo = "method=flickr.photos.getInfo"
}
