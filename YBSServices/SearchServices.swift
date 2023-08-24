//
//  SearchServices.swift
//  YBSServices
//
//  Created by Lenard Pop on 24/08/2023.
//

import Foundation
import Combine

public class SearchServices: SearchServicesProtocol {
    private var networking: NetworkingProtocol = Networking()
    private var urlProvider: URLProviderProtocol = URLProvider()

    public init() { }

    internal convenience init(networking: NetworkingProtocol, urlProvider: URLProviderProtocol) {
        self.init()
        self.networking = networking
        self.urlProvider = urlProvider
    }

    public func fetchRecentResults(page: Int = 1) -> AnyPublisher<SearchResponseModel, Error> {
        return networking
            .fetchData(url: urlProvider.getRecentPhotosURL(page: page))
    }

    public func fetchSearchResults(search query: String, tagMode: FlickrTagMode = .Some, page: Int? = nil) -> AnyPublisher<SearchResponseModel, Error> {
        return networking
            .fetchData(url: urlProvider.getSearchQueryPhotosURL(query: query, tagMode: tagMode, page: page))
    }
}
