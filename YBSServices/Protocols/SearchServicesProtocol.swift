//
//  SearchServicesProtocol.swift
//  YBSServices
//
//  Created by Lenard Pop on 24/08/2023.
//

import Foundation
import Combine

public protocol SearchServicesProtocol {
    func fetchRecentResults(page: Int) -> AnyPublisher<SearchResponseModel, Error>
    func fetchSearchResults(search query: String, tagMode: FlickrTagMode, page: Int?) -> AnyPublisher<SearchResponseModel, Error>
}
