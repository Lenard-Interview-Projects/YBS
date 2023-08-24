//
//  PhotoService.swift
//  YBSServices
//
//  Created by Lenard Pop on 27/08/2023.
//

import Foundation
import Combine

public final class PhotoServices: PhotoServicesProtocol {
    private var networking: NetworkingProtocol = Networking()
    private var urlProvider: URLProviderProtocol = URLProvider()

    public init() { }

    internal convenience init(networking: NetworkingProtocol, urlProvider: URLProviderProtocol) {
        self.init()
        self.networking = networking
        self.urlProvider = urlProvider
    }

    public func fetchPhotoInfo(photoId: String) -> AnyPublisher<PhotoResponseModel, Error> {
        return networking
            .fetchData(url: urlProvider.getPhotoInfoURL(photoId: photoId))
    }
}
