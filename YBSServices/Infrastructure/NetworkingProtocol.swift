//
//  NetworkingProtocol.swift
//  YBSServices
//
//  Created by Lenard Pop on 24/08/2023.
//

import Foundation
import Combine

internal protocol NetworkingProtocol {
    func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, Error>
}
