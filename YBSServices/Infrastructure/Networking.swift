//
//  Networking.swift
//  YBSServices
//
//  Created by Lenard Pop on 24/08/2023.
//

import Foundation
import Combine

internal class Networking: NetworkingProtocol {

    init() { }

    internal func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, Error> {
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        guard let url = URL(string: encodedURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        print("Fetched URL:")
        print(url)

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
